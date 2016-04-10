source("join.zoo.R")
source("signal_process.R")
source("backtest.R")
source("simple_rolling_mean.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("momentum_bonds.pdf")
par(xpd=TRUE)

#bonds
bond_list = c("GER","JPN","USA","GBR", "CGB")
bonds <- merge(CME_bund, CME_JGB,CME_TY, CME_GILT, CME_CGB)
colnames(bonds) <- bond_list

plot.zoo(bonds, plot.type = "multiple", main = "Bond Price")
plot.zoo(bonds, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "Bond Price")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_return <- na.omit(diff(log(bonds)))
bond_momentum_raw <- zoo(apply(bond_return,2,simple_rolling_mean), time(bond_return))
bond_momentum_raw <- bond_momentum_raw[253:dim(bond_momentum_raw)[1],]

plot.zoo(bond_momentum_raw, plot.type = "multiple", main = "Momentum Raw Signal")
plot.zoo(bond_momentum_raw, plot.type = "single", col = mycols, main = "Momentum Raw Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_momentum_processed <- signal_process(bond_momentum_raw,bond_return)
plot.zoo(bond_momentum_processed, plot.type = "multiple", main = "Momentum Processed Signal")
plot.zoo(bond_momentum_processed, plot.type = "single", col = mycols, main = "Momentum Processed Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)
bond_momentum_res <- backtest(bond_momentum_processed,bond_return)

plot.zoo(bond_momentum_res$pnl, main = "Momentum Bond Performance")
barplot(bond_momentum_res$leadLag, main = "Momentum Bond Lead Lag Analysis")

dev.off()

