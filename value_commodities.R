source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
sdate = "1990-01-01"
edate = "2016-03-07"

pdf("value_commodities.pdf")
par(xpd=TRUE)

Commodities
commodity_list = c("CME_wti","CME_NG","CME_HO","CME_RB","ICE_Brent","CME_C",
                   "CME_S","CME_W","CME_GC","SHFE_CU")
commodity_return <- merge(Extract.Returns(CME_wti),Extract.Returns(CME_NG),
                          Extract.Returns(CME_HO),Extract.Returns(CME_RB),
                          Extract.Returns(ICE_Brent),Extract.Returns(CME_C),
                          Extract.Returns(CME_S),Extract.Returns(CME_W),
                          Extract.Returns(CME_GC),Extract.Returns(SHFE_CU))
colnames(commodity_return) <- commodity_list
for(i in 1:dim(energy_return)[2]){
  commodity_return[is.na(commodity_return[,i]),i]<-0
}
plot.zoo(cumsum(commodity_return), plot.type = "multiple", main = "commodity prices")
plot.zoo(cumsum(commodity_return), plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Commodity Prices")

commodities <- cumsum(commodity_return)

commodities_lag <- lag(commodities,1261)
commodity_value_raw <- commodities/commodities_lag
commodity_value_raw <- commodity_value_raw[1261:dim(commodity_value_raw)[1],]
plot.zoo(commodity_value_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(commodity_value_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_value_processed <- signal_process(commodity_value_raw,commodity_returns)
plot.zoo(commodity_value_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(commodity_value_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_value_res <- backtest(as.zoo(commodity_value_processed), commodity_returns)
plot.zoo(commodity_value_res$pnl, main = "Value Commodity Performance")
barplot(commodity_value_res$leadLag, main = "Value Commodity Lead Lag Analysis")

dev.off()

