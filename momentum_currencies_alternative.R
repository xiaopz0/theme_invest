source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process_alternative.R")
source("backtest.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("momentum_currencies_alternative.pdf")
par(xpd=TRUE)

#Currencies
currency_list = c("AUD","CAD","CHF","EUR","GBP","JPY","NZD","USD")
currencies <- merge(CME_AUD$Close,CME_CAD$Close,CME_CHF$Close,CME_EUR$Close,CME_GBP$Close,CME_JPY$Close,CME_NZD$Close,USD$Close)
colnames(currencies) <- currency_list

plot.zoo(currencies, plot.type = "multiple", main = "Exchange Rate")
plot.zoo(currencies, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Exchange Rate")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

one_year_SMA <- function(x){return(SMA(x,252))}

currency_return <- na.omit(diff(log(currencies)))
currency_momentum_raw <- zoo(apply(currency_return,2,one_year_SMA), time(currency_return))
currency_momentum_raw <- currency_momentum_raw[253:dim(currency_momentum_raw)[1],]

plot.zoo(currency_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(currency_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_momentum_processed <- signal_process_alternative(currency_momentum_raw,currency_return)
plot.zoo(currency_momentum_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(currency_momentum_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_momentum_res <- backtest(currency_momentum_processed,currency_return)
plot.zoo(currency_momentum_res$pnl, main = "Momentum Currency Performance")
barplot(currency_momentum_res$leadLag, main = "Momentum Currency Lead Lag Analysis")

dev.off()
