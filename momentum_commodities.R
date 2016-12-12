source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
source("simple_rolling_mean.R")

pdf("momentum_commodities.pdf")
par(xpd=TRUE)

###############################
# signal construction
###############################
#Commodities
commodity_list = c("CME_wti","CME_NG","CME_HO","CME_RB","ICE_Brent","CME_C",
                   "CME_S","CME_W","CME_GC","SHFE_CU")
commodity_return <- merge(Extract.Returns(CME_wti),Extract.Returns(CME_NG),
                       Extract.Returns(CME_HO),Extract.Returns(CME_RB),
                       Extract.Returns(ICE_Brent),Extract.Returns(CME_C),
                       Extract.Returns(CME_S),Extract.Returns(CME_W),
                       Extract.Returns(CME_GC),Extract.Returns(SHFE_CU))
colnames(commodity_return) <- commodity_list
for(i in 1:dim(commodity_return)[2]){
  commodity_return[is.na(commodity_return[,i]),i]<-0
  commodity_return[is.infinite(commodity_return[,i]),i]<-0
}
plot.zoo(cumsum(commodity_return), plot.type = "multiple", main = "commodity prices")
plot.zoo(cumsum(commodity_return), plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Commodity Prices")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_raw <- zoo(apply(commodity_return,2,simple_rolling_mean), time(commodity_return))
commodity_momentum_raw <- commodity_momentum_raw[253:dim(commodity_momentum_raw)[1],]

plot.zoo(commodity_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(commodity_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

###############################
# backtest
###############################
# cross sectional
commodity_momentum_processed_cs <- signal_process(commodity_momentum_raw,commodity_return)
plot.zoo(commodity_momentum_processed_cs, plot.type = "multiple", main = "CS Processed Signal")
plot.zoo(commodity_momentum_processed_cs, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "CS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_res_cs <- backtest(commodity_momentum_processed_cs,commodity_return)
plot.zoo(commodity_momentum_res_cs$pnl, main = "CS Momentum Commodity Performance")
barplot(commodity_momentum_res_cs$leadLag$leadLag, main = "CS Momentum Commodity Lead Lag Analysis")
plot.zoo(commodity_momentum_res_cs$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "cs commodity momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(commodity_momentum_res_ts$leadLag$leadLagPnL[,7:9]) )

# time series
commodity_momentum_processed_ts <- signal_process_alternative(commodity_momentum_raw,commodity_return)
plot.zoo(commodity_momentum_processed_ts, plot.type = "multiple", main = "TS Processed Signal")
plot.zoo(commodity_momentum_processed_ts, plot.type = "single", col = mycols, main = "TS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_res_ts <- backtest(commodity_momentum_processed_ts,commodity_return)
plot.zoo(commodity_momentum_res_ts$pnl, main = "TS Momentum Commodity Performance")
barplot(commodity_momentum_res_ts$leadLag$leadLag, main = "TS Momentum Commodity Lead Lag Analysis")
plot.zoo(commodity_momentum_res_ts$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts commodity momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(commodity_momentum_res_ts$leadLag$leadLagPnL[,7:9]) )

# discrete
commodity_momentum_processed_discrete <- signal_process_discrete(commodity_momentum_raw,commodity_return)
plot.zoo(commodity_momentum_processed_discrete, plot.type = "multiple", main = "TS Discrete Processed Signal")
plot.zoo(commodity_momentum_processed_discrete, plot.type = "single", col = mycols, main = "TS Discrete Processed Signal")
legend("topright", inset=c(-0.03,0), legend=commodity_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_res_discrete <- backtest(commodity_momentum_processed_discrete,commodity_return, discrete = T, price = prices)
plot.zoo(commodity_momentum_res_discrete$pnl, main = "TS Discrete Momentum Commodity Performance")
barplot(commodity_momentum_res_discrete$leadLag$leadLag, main = "TS Discrete Momentum Commodity Lead Lag Analysis")
plot.zoo(commodity_momentum_res_discrete$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts discrete commodity momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(commodity_momentum_res_discrete$leadLag$leadLagPnL[,7:9]) )

dev.off()
