source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process.R")
source("backtest.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("value_bonds.pdf")
par(xpd=TRUE)

#Currencies
bond_list = c("CAN","GER","JPN","USA","GBR")
bonds <- merge(CME_CGB,CME_bund, CME_JGB,CME_TY, CME_GILT)
colnames(bonds) <- bond_list
YIELDs <- merge(YIELD_CAN,YIELD_GER,YIELD_JPN,YIELD_USA,YIELD_GBR)
colnames(YIELDs) <- bond_list
plot.zoo(bonds, plot.type = "multiple", main = "Implied Bond Price")

plot.zoo(YIELDs, plot.type = "multiple")
plot.zoo(YIELDs, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), xlab = "", main = "Bond Yields")
legend("topright", inset=c(-0,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_value_raw <- YIELDs-lag(YIELDs,-1261)
bond_value_raw <- bond_value_raw[1261:dim(bond_value_raw)[1],]
plot.zoo(bond_value_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(bond_value_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), xlab = "", main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_price <- 100*1/(1+YIELDs/100)
bond_returns <- diff(log(bond_price))

bond_value_processed <- signal_process(bond_value_raw,bond_returns)
plot.zoo(bond_value_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(bond_value_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=bond_list, lty = 1, col = mycols,cex=0.6)

bond_value_res <- backtest(as.zoo(bond_value_processed),bond_returns)
plot.zoo(bond_value_res$pnl, main = "Value Bond Performance")
barplot(bond_value_res$leadLag, main = "Value Bond Lead Lag Analysis")

dev.off()
