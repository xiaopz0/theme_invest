source("momentum_commodities_alternative.R")
source("momentum_currencies_alternative.R")
source("momentum_bonds_alternative.R")
source("momentum_stocks_alternative.R")
par(xpd=TRUE)

asset_class <- c("commodity","equity","currency","bond")
momentum_alternative <- merge(commodity_momentum_res$pnl,equity_momentum_res$pnl,currency_momentum_res$pnl,bond_momentum_res$pnl)
colnames(momentum_alternative) <- asset_class

plot.zoo(momentum_alternative, plot.type = "multiple", main = "Momentum Performance by Asset Class")
plot.zoo(momentum_alternative, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Momentum Performance by Asset Class")
legend("bottomleft", inset=c(-0,-0), legend=asset_class, lty = 1, col = mycols,cex=0.6)

momentum_alternative <- na.locf(momentum_alternative)
remove_na <- function(x){x[is.na(x)]<-0; return(x)}
momentum_alternative <- as.zoo(apply(momentum_alternative, 2, remove_na), time(momentum_alternative))

momentum_alternative_total_pnl <- zoo(rowSums(momentum_alternative), time(momentum_alternative))
plot.zoo(momentum_alternative_total_pnl, main = "Momentum Performance")
