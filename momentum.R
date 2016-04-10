source("momentum_commodities.R")
source("momentum_currencies.R")
source("momentum_bonds.R")
source("momentum_stocks.R")
par(xpd=TRUE)

asset_class <- c("commodity","equity","currency","bond")
momentum <- merge(commodity_momentum_res$pnl,equity_momentum_res$pnl,currency_momentum_res$pnl,bond_momentum_res$pnl)
colnames(momentum) <- asset_class

plot.zoo(momentum, plot.type = "multiple", main = "Momentum Performance by Asset Class")
plot.zoo(momentum, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Momentum Performance by Asset Class")
legend("bottomleft", inset=c(-0,-0), legend=asset_class, lty = 1, col = mycols,cex=0.6)

momentum <- na.locf(momentum)
remove_na <- function(x){x[is.na(x)]<-0; return(x)}
momentum <- as.zoo(apply(momentum, 2, remove_na), time(momentum))

momentum_total_pnl <- zoo(rowSums(momentum), time(momentum))
plot.zoo(momentum_total_pnl, main = "Momentum Performance")
