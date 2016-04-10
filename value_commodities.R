source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
sdate = "1990-01-01"
edate = "2016-03-07"

pdf("value_commodities.pdf")
par(xpd=TRUE)

#Currencies
commodity_list = c("WTI","NG","HO","CORN","SOY","WHEAT","Gold","USD")
commodities <- merge(CME_wti$Close,CME_NG$Close,CME_HO$Close,CME_C$Close,CME_S$Close,CME_W$Close,CME_GC$Close,CME_HG$Close)
colnames(commodities) <- commodity_list

plot.zoo(commodities, plot.type = "multiple", main = "Commodity Price")
plot.zoo(commodities, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Commodity Price")

commodities_lag <- lag(commodities,1261)
commodity_value_raw <- commodities/commodities_lag
commodity_value_raw <- commodity_value_raw[1261:dim(commodity_value_raw)[1],]
plot.zoo(commodity_value_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(commodity_value_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_returns <- diff(log(commodities))
commodity_value_processed <- signal_process(commodity_value_raw,commodity_returns)
plot.zoo(commodity_value_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(commodity_value_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_value_res <- backtest(as.zoo(commodity_value_processed), commodity_returns)
plot.zoo(commodity_value_res$pnl, main = "Value Commodity Performance")
barplot(commodity_value_res$leadLag, main = "Value Commodity Lead Lag Analysis")

dev.off()

