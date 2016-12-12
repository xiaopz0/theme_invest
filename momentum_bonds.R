source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
source("simple_rolling_mean.R")

pdf(paste("momentum_bonds.pdf"))
par(xpd=TRUE)

###############################
# signal construction
###############################
#bonds
bond_list = c("CME_bund","CME_TY","CME_GILT")
bond_return <- merge(Extract.Returns(CME_bund), 
                     Extract.Returns(CME_TY), 
                     Extract.Returns(CME_GILT))
colnames(bond_return) <- bond_list

for(i in 1:dim(bond_return)[2]){
  bond_return[is.na(bond_return[,i]),i]<-0
}
plot.zoo(cumsum(bond_return), plot.type = "multiple", 
         main = "bond prices")
plot.zoo(cumsum(bond_return), plot.type = "single", col = mycols, 
         main = "Bond Prices")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, 
       col = mycols,cex=0.6)

bond_momentum_raw <- zoo(apply(bond_return,2,simple_rolling_mean), 
                         time(bond_return))
bond_momentum_raw <- bond_momentum_raw[253:dim(bond_momentum_raw)[1],]

plot.zoo(bond_momentum_raw, plot.type = "multiple", main = "Momentum Raw Signal")
plot.zoo(bond_momentum_raw, plot.type = "single", col = mycols, main = "Momentum Raw Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

###############################
# backtest
###############################
# cross sectional
bond_momentum_processed_cs <- signal_process(bond_momentum_raw,bond_return)
plot.zoo(bond_momentum_processed_cs, plot.type = "multiple", main = "CS Momentum Processed Signal")
plot.zoo(bond_momentum_processed_cs, plot.type = "single", col = mycols, main = "CS Momentum Processed Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)
bond_momentum_res_cs <- backtest(bond_momentum_processed_cs,bond_return)
plot.zoo(bond_momentum_res_cs$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts bond momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(bond_momentum_res_cs$leadLag$leadLagPnL[,7:9]) )

plot.zoo(bond_momentum_res_cs$pnl, main = "CS Momentum Bond Performance")
barplot(bond_momentum_res_cs$leadLag$leadLag, main = "CS Momentum Bond Lead Lag Analysis")

# time series
bond_momentum_processed_ts <- signal_process_alternative(bond_momentum_raw,bond_return)
plot.zoo(bond_momentum_processed_ts, plot.type = "multiple", main = "TS Momentum Processed Signal")
plot.zoo(bond_momentum_processed_ts, plot.type = "single", col = mycols, main = "TS Momentum Processed Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)
bond_momentum_res_ts <- backtest(bond_momentum_processed_ts,bond_return)

plot.zoo(bond_momentum_res_ts$pnl, main = "TS Momentum Bond Performance")
barplot(bond_momentum_res_ts$leadLag$leadLag, main = "TS Momentum Bond Lead Lag Analysis")
plot.zoo(bond_momentum_res_ts$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts bond momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(bond_momentum_res_ts$leadLag$leadLagPnL[,7:9]) )

# discrete
bond_momentum_processed_discrete <- signal_process_discrete(bond_momentum_raw,bond_return)
plot.zoo(bond_momentum_processed_discrete, plot.type = "multiple", main = "TS Discrete Processed Signal")
plot.zoo(bond_momentum_processed_discrete, plot.type = "single", col = mycols, main = "TS Discrete Processed Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_momentum_res_discrete <- backtest(bond_momentum_processed_discrete,bond_return, discrete = T, price = prices)
plot.zoo(bond_momentum_res_discrete$pnl, main = "TS Discrete Momentum Bond Performance")
barplot(bond_momentum_res_discrete$leadLag$leadLag, main = "TS Discrete Momentum Bond Lead Lag Analysis")
plot.zoo(bond_momentum_res_discrete$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "ts discrete bond momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(bond_momentum_res_discrete$leadLag$leadLagPnL[,7:9]) )

dev.off()

