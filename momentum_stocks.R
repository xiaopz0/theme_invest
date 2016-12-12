source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")

pdf("momentum_equities.pdf")
par(xpd=TRUE)

###############################
# signal construction
###############################
#equities
equity_list = c("CME_ES_EQ","CME_MD_EQ","CME_NQ_EQ","CME_NK_EQ","CME_DX_EQ","CME_FTSE_EQ")
equity_return <- merge(Extract.Returns(CME_ES_EQ),Extract.Returns(CME_MD_EQ),
                       Extract.Returns(CME_NQ_EQ),Extract.Returns(CME_NK_EQ),
                       Extract.Returns(CME_DX_EQ),Extract.Returns(CME_FTSE_EQ))

colnames(equity_return) <- equity_list
for(i in 1:dim(equity_return)[2]){
  equity_return[is.na(equity_return[,i]),i]<-0
}
plot.zoo(cumsum(equity_return), plot.type = "multiple", main = "equity prices")
plot.zoo(cumsum(equity_return), plot.type = "single", col = mycols, main = "equity_price")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_momentum_raw <- zoo(apply(equity_return,2,simple_rolling_mean), time(equity_return))
equity_momentum_raw <- equity_momentum_raw[253:dim(equity_momentum_raw)[1],]

plot.zoo(equity_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(equity_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

###############################
# backtest
###############################
# cross sectional
equity_momentum_processed_cs <- signal_process(equity_momentum_raw,equity_return)
plot.zoo(equity_momentum_processed_cs, plot.type = "multiple", main = "CS Processed Signal")
plot.zoo(equity_momentum_processed_cs, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "CS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_return[abs(equity_return[,4])>0.2,4]<-0
equity_momentum_res_cs <- backtest(equity_momentum_processed_cs,equity_return)
plot.zoo(equity_momentum_res_cs$pnl, main = "CS Momentum Equity Performance")
barplot(equity_momentum_res_cs$leadLag$leadLag, main = "CS Momentum Equity Lead Lag Analysis")
plot.zoo(equity_momentum_res_cs$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(equity_momentum_res_cs$leadLag$leadLagPnL[,7:9]) )

# time series
equity_momentum_processed_ts <- signal_process_alternative(equity_momentum_raw,equity_return)
plot.zoo(equity_momentum_processed_ts, plot.type = "multiple", main = "TS Processed Signal")
plot.zoo(equity_momentum_processed_ts, plot.type = "single", col = mycols, main = "TS Processed Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_return[abs(equity_return[,4])>0.2,4]<-0
equity_momentum_res_ts <- backtest(equity_momentum_processed_ts,equity_return)
plot.zoo(equity_momentum_res_ts$pnl, main = "TS Momentum Equity Performance")
barplot(equity_momentum_res_ts$leadLag$leadLag, main = "TS Momentum Equity Lead Lag Analysis")
plot.zoo(equity_momentum_res_ts$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(equity_momentum_res_ts$leadLag$leadLagPnL[,7:9]) )

# discrete
equity_momentum_processed_discrete <- signal_process_discrete(equity_momentum_raw,equity_return)
plot.zoo(equity_momentum_processed_discrete, plot.type = "multiple", main = "TS Discrete Processed Signal")
plot.zoo(equity_momentum_processed_discrete, plot.type = "single", col = mycols, main = "TS Discrete Processed Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_momentum_res_discrete <- backtest(equity_momentum_processed_discrete,equity_return, discrete = T, price = prices)
plot.zoo(equity_momentum_res_discrete$pnl, main = "TS Discrete Momentum Equity Performance")
barplot(equity_momentum_res_discrete$leadLag$leadLag, main = "TS Discrete Momentum Equity Lead Lag Analysis")
plot.zoo(equity_momentum_res_discrete$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts discrete equity momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(equity_momentum_res_discrete$leadLag$leadLagPnL[,7:9]) )

dev.off()

