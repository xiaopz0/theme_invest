bond_index_return <- zoo(rowMeans(diff(log(bonds)), na.rm = T), time(bonds))
equity_index_return <- zoo(rowMeans(diff(log(equities)), na.rm = T), time(equities))
commodity_index_return <- zoo(rowMeans(diff(log(commodities)), na.rm = T), time(equities))
currency_index_return <- zoo(rowMeans(diff(log(currencies)), na.rm = T), time(equities))

asset_class <- c("commodity","equity","currency","bond")
Index_returns <- merge(commodity_index_return,equity_index_return,currency_index_return,bond_index_return)

remove_na <- function(x){x[is.na(x)]<-0; return(x)}
Index_returns <- as.zoo(apply(Index_returns, 2, remove_na), time(Index_returns))

require(quantmod)
require(PerformanceAnalytics)  

plot(cumsum(Index_returns), xlab="", ylab = "Equal Weight Indices", plot.type = "single", col = mycols)
legend("bottomright", inset=c(-0.1,0), legend=asset_class, lty = 1, col = mycols,cex=0.6)
title("Asset Class Returns")
index.draw = table.Drawdowns(Index_returns[,2])   #jpeg(filename="DJ plot with Drawdowns zoo.jpg",
xblocks(index(Index_returns),as.vector(index.draw[,4] < -0.20),col = rgb[1])

chart.Drawdown(Index_returns[,1:4],
               main="Drawdown from Peak Return Attained",
               legend.loc="bottomleft")
