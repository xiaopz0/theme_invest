source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")

CME_ES_EQ <- quandClean("CHRIS/CME_ES", start_date=from, end_date=to, verbose=verbose) #Emini
CME_MD_EQ <- quandClean("CHRIS/CME_MD", start_date=from, end_date=to, verbose=verbose) #Midcap 400
CME_NQ_EQ <- quandClean("CHRIS/CME_NQ", start_date=from, end_date=to, verbose=verbose) #Nasdaq 100
CME_NK_EQ <- quandClean("CHRIS/CME_NK", start_date=from, end_date=to, verbose=verbose) #Nikkei
CME_DX_EQ <- quandClean("CHRIS/EUREX_FDAX", start_date=from, end_date=to, verbose=verbose) #DAX
CME_SF_EQ <- quandClean("CHRIS/EUREX_FMZA", start_date=from, end_date=to, verbose=verbose) #South Africa
CME_FTSE_EQ <- quandClean("CHRIS/LIFFE_Z", start_date=from, end_date=to, verbose=verbose) #FTSE

PB_ratio_SP <- read.zoo(Quandl("BUNDESBANK/BBQFS_M_US_CORP_PX_BOOK_SP500__X_0000", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
PB_ratio_DAX <- read.zoo(Quandl("BUNDESBANK/BBQFS_M_DE_CORP_PX_BOOK_DAX__X_0000", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")


sdate = "1990-01-01"
edate = "2016-03-07"

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
plot.zoo(RERs, plot.type = "multiple")
plot.zoo(RERs[,-6], plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"))

curreny_value_raw <- RERs/lag(RERs,1261)
curreny_value_raw <- curreny_value_raw[1261:dim(RERs)[1],]
plot.zoo(curreny_value_raw, plot.type = "multiple")
plot.zoo(curreny_value_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"))
currency_return <- diff(log(currencies))

curreny_value_processed <- signal_process(curreny_value_raw,)
plot.zoo(curreny_value_processed, plot.type = "multiple")
plot.zoo(curreny_value_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"))

res <- backtest(curreny_value_processed,)

