source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
sdate = "1990-01-01"
edate = "2016-03-07"

pdf("value_currencies.pdf")
par(xpd=TRUE)

CPI_AUD <- read.zoo(Quandl("RATEINF/CPI_AUS", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_CAD <- read.zoo(Quandl("RATEINF/CPI_CAN", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_EUR <- read.zoo(Quandl("RATEINF/CPI_EUR", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_CHF <- read.zoo(Quandl("RATEINF/CPI_CHE", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_GBP <- read.zoo(Quandl("RATEINF/CPI_GBR", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_JPY <- read.zoo(Quandl("RATEINF/CPI_JPN", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_NZD <- read.zoo(Quandl("RATEINF/CPI_NZL", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
CPI_USD <- read.zoo(Quandl("RATEINF/CPI_USA", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")

#Currencies
currency_list = c("AUD","CAD","CHF","EUR","GBP","JPY","NZD","USD")
currencies <- merge(CME_AUD$Close,CME_CAD$Close,CME_CHF$Close,CME_EUR$Close,CME_GBP$Close,CME_JPY$Close,CME_NZD$Close,USD$Close)
colnames(currencies) <- currency_list
CPIs <- merge(CPI_AUD,CPI_CAD,CPI_CHF,CPI_EUR,CPI_GBP,CPI_JPY,CPI_NZD,CPI_USD)
RERs <- currencies
RERs[,] <- NA

for(i in 1:8){
  real_exchange_rate_tmp <- real_exchange_rate(CPIs[,i], as.zoo(currencies[,i]),sdate,edate)
  common_date <- as.Date(intersect(time(RERs),time(real_exchange_rate_tmp)))
  RERs[common_date,i] <- real_exchange_rate_tmp[common_date]                      
}
plot.zoo(RERs, plot.type = "multiple", main = "Real Exchange Rate")
plot.zoo(RERs[,-6], plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Real Exchange Rate")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

curreny_value_raw <- RERs/lag(RERs,1261)
curreny_value_raw <- curreny_value_raw[1261:dim(RERs)[1],]
plot.zoo(curreny_value_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(curreny_value_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_returns <- diff(log(currencies))
curreny_value_processed <- signal_process(curreny_value_raw,currency_returns)
plot.zoo(curreny_value_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(curreny_value_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_value_res <- backtest(as.zoo(curreny_value_processed),currency_returns)
plot.zoo(currency_value_res$pnl, main = "Value Currency Performance")
barplot(currency_value_res$leadLag, main = "Value Currency Lead Lag Analysis")

dev.off()
