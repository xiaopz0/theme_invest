source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("momentum_currencies.pdf")
par(xpd=TRUE)

###############################
# signal construction
###############################
#Currencies
currency_list = c("AUD","CAD","CHF","EUR","GBP","JPY","NZD","USD")
currency_return <- merge(Extract.Returns(CME_AUD),Extract.Returns(CME_CAD),
                    Extract.Returns(CME_CHF),Extract.Returns(CME_EUR),
                    Extract.Returns(ICE_GBP),Extract.Returns(CME_JPY),
                    Extract.Returns(CME_NZD),Extract.Returns(USD))

colnames(currency_return) <- currency_list
for(i in 1:dim(currency_return)[2]){
  currency_return[is.na(currency_return[,i]),i]<-0
}
plot.zoo(cumsum(currency_return), plot.type = "multiple", main = "currency prices")
plot.zoo(cumsum(currency_return), plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Currency Prices")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

commodity_momentum_raw <- zoo(apply(currency_return,2,simple_rolling_mean), time(commodity_return))
commodity_momentum_raw <- commodity_momentum_raw[253:dim(commodity_momentum_raw)[1],]

plot.zoo(currency_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(currency_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

###############################
# backtest
###############################
# cross sectional
currency_momentum_processed_cs <- signal_process(currency_momentum_raw,currency_return)
plot.zoo(currency_momentum_processed_cs, plot.type = "multiple", main = "CS Processed Signal")
plot.zoo(currency_momentum_processed_cs, plot.type = "single", col = mycols, main = "CS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_momentum_res_cs <- backtest(currency_momentum_processed_cs,currency_return)
plot.zoo(currency_momentum_res_cs$pnl, main = "CS Momentum Currency Performance")
barplot(currency_momentum_res_cs$leadLag$leadLag, main = "CS Momentum Currency Lead Lag Analysis")
plot.zoo(currency_momentum_res_cs$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "cs currency momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(currency_momentum_res_cs$leadLag$leadLagPnL[,7:9]) )

# time series
currency_momentum_processed_ts <- signal_process_alternative(currency_momentum_raw,currency_return)
plot.zoo(currency_momentum_processed_ts, plot.type = "multiple", main = "TS Processed Signal")
plot.zoo(currency_momentum_processed_ts, plot.type = "single", col = mycols, main = "TS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_momentum_res_ts <- backtest(currency_momentum_processed_ts,currency_return)
plot.zoo(currency_momentum_res_ts$pnl, main = "TS Momentum Currency Performance")
barplot(currency_momentum_res_ts$leadLag$leadLag, main = "TS Momentum Currency Lead Lag Analysis")
plot.zoo(currency_momentum_res_ts$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "cs currency momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(currency_momentum_res_ts$leadLag$leadLagPnL[,7:9]) )

# discrete
currency_momentum_processed_discrete <- signal_process_discrete(currency_momentum_raw,currency_return)
plot.zoo(currency_momentum_processed_discrete, plot.type = "multiple", main = "TS Discrete Processed Signal")
plot.zoo(currency_momentum_processed_discrete, plot.type = "single", col = mycols, main = "TS Discrete Processed Signal")
legend("topright", inset=c(-0.03,0), legend=currency_list, lty = 1, col = mycols,cex=0.6)

currency_momentum_res_discrete <- backtest(currency_momentum_processed_discrete,currency_return, discrete = T, price = prices)
plot.zoo(currency_momentum_res_discrete$pnl, main = "TS Discrete Momentum Currency Performance")
barplot(currency_momentum_res_discrete$leadLag$leadLag, main = "TS Discrete Momentum Currency Lead Lag Analysis")
plot.zoo(currency_momentum_res_discrete$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts discrete currency momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(currency_momentum_res_discrete$leadLag$leadLagPnL[,7:9]) )

dev.off()
