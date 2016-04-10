source("value_commodities.R")
source("value_currencies.R")
source("value_bonds.R")
asset_class <- c("commodity","currency","bond")
value <- merge(commodity_value_res$pnl,currency_value_res$pnl,bond_value_res$pnl)
colnames(value) <- asset_class

plot.zoo(value, plot.type = "multiple", main = "Value Performance By Asset Class")
plot.zoo(value, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Value Performance By Asset Class")
legend("bottomleft", inset=c(-0,-0), legend=asset_class, lty = 1, col = mycols,cex=0.6)

value <- na.locf(value)
remove_na <- function(x){x[is.na(x)]<-0; return(x)}
value <- as.zoo(apply(value, 2, remove_na), time(value))

total_pnl <- zoo(rowSums(value), time(value))
plot.zoo(total_pnl, main = "Value Performance")
