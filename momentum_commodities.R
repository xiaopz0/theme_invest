source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
source("simple_rolling_mean.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("momentum_commodities.pdf")
par(xpd=TRUE)

#Currencies
commodity_list = c("WTI","NG","HO","CORN","SOY","WHEAT","Gold","Copper")
commodities <- merge(CME_wti$Close,CME_NG$Close,CME_HO$Close,CME_C$Close,CME_S$Close,CME_W$Close,CME_GC$Close,CME_HG$Close)
colnames(commodities) <- commodity_list

plot.zoo(commodities, plot.type = "multiple", main = "Commodity Prices")
plot.zoo(commodities, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Commodity Prices")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_return <- na.omit(diff(log(commodities)))
commodity_momentum_raw <- zoo(apply(commodity_return,2,simple_rolling_mean), time(commodity_return))
commodity_momentum_raw <- commodity_momentum_raw[253:dim(commodity_momentum_raw)[1],]

plot.zoo(commodity_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(commodity_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_processed <- signal_process(commodity_momentum_raw,commodity_return)
plot.zoo(commodity_momentum_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(commodity_momentum_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_res <- backtest(commodity_momentum_processed,commodity_return)
plot.zoo(commodity_momentum_res$pnl, main = "Momentum Commodity Performance")
barplot(commodity_momentum_res$leadLag, main = "Momentum Commodity Lead Lag Analysis")

dev.off()
