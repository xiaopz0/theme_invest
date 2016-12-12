source("momentum_commodities.R")
source("momentum_currencies.R")
source("momentum_bonds.R")
source("momentum_stocks.R")
library(PerformanceAnalytics)
pdf("momentum.pdf")
par(xpd=TRUE)

###############################
# asset class performance
###############################
# time series
asset_class <- c("commodity","equity","currency","bond")
momentum_ts <- merge(commodity_momentum_res_ts$pnl,
                  equity_momentum_res_ts$pnl,
                  currency_momentum_res_ts$pnl,
                  bond_momentum_res_ts$pnl)
colnames(momentum_ts) <- asset_class

plot.zoo(momentum_ts, plot.type = "multiple", 
         main = "TS Momentum Performance by Asset Class")
plot.zoo(momentum_ts, plot.type = "single", col = mycols, 
         main = "TS Momentum Performance by Asset Class")
legend("bottomleft", inset=c(-0,-0), legend=asset_class, 
       lty = 1, col = mycols,cex=0.6)

momentum_ts <- na.locf(momentum_ts)
remove_na <- function(x){x[is.na(x)]<-0; return(x)}
momentum_ts <- as.zoo(apply(momentum_ts, 2, remove_na), time(momentum_ts))

momentum_ts_total_pnl <- zoo(rowSums(momentum_ts), time(momentum_ts))
plot.zoo(momentum_ts_total_pnl, main = "TS Momentum Performance")

# discrete
asset_class <- c("commodity","equity","currency","bond")
momentum_discrete <- merge(commodity_momentum_res_discrete$pnl,
                     equity_momentum_res_discrete$pnl,
                     currency_momentum_res_discrete$pnl,
                     bond_momentum_res_discrete$pnl)
colnames(momentum_discrete) <- asset_class

plot.zoo(momentum_discrete, plot.type = "multiple", 
         main = "TS Discrete Momentum Performance by Asset Class")
plot.zoo(momentum_discrete, plot.type = "single", col = mycols, 
         main = "TS Discrete Momentum Performance by Asset Class")
legend("bottomleft", inset=c(-0,-0), legend=asset_class, 
       lty = 1, col = mycols,cex=0.6)

momentum_discrete <- na.locf(momentum_discrete)
remove_na <- function(x){x[is.na(x)]<-0; return(x)}
momentum_discrete <- as.zoo(apply(momentum_discrete, 2, remove_na), time(momentum_discrete))

momentum_discrete_total_pnl <- zoo(rowSums(momentum_discrete), time(momentum_discrete))
plot.zoo(momentum_discrete_total_pnl, main = "TS Discrete Momentum Performance")

chart.RollingMean(diff(momentum_discrete_total_pnl), width = 252,
                  legend.loc="topleft")

###############################
# backtest performance
###############################
# time series
momentum_processed_ts <- merge(bond_momentum_processed_ts, 
                               commodity_momentum_processed_ts,
                               currency_momentum_processed_ts,
                               equity_momentum_processed_ts)
momentum_returns <- merge(equity_return, bond_return, 
                          commodity_return, currency_return)
for(i in 1:dim(momentum_returns)[2]){
  momentum_returns[is.na(momentum_returns[,i]),i]<-0
}
momentum_ts_results <- backtest(momentum_processed_ts,momentum_returns)
barplot(momentum_ts_results$leadLag$leadLag, main = "momentum leadlag")
plot.zoo(momentum_ts_results$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(momentum_ts_results$leadLag$leadLagPnL[,7:9]) )
daily_pnl <- diff(momentum_ts_results$pnl)
charts.PerformanceSummary(log(daily_pnl/10+1),ylog=TRUE,
                          period.areas = drawdowns.dates,period.color = rgb[1],
                          colorset=c(2,3,4),
                          legend.loc="topleft",
                          main = "Momentum TS PnL" )

chart.RollingMean(log(daily_pnl/10+1), width = 252,
                  legend.loc="topleft")

chart.Histogram(log(daily_pnl/10+1), main = "momentum pnl distribution")

# discrete
momentum_processed_discrete <- merge(bond_momentum_processed_discrete, 
                               commodity_momentum_processed_discrete,
                               currency_momentum_processed_discrete,
                               equity_momentum_processed_discrete)
momentum_returns <- merge(equity_return, bond_return, 
                          commodity_return, currency_return)
for(i in 1:dim(momentum_returns)[2]){
  momentum_returns[is.na(momentum_returns[,i]),i]<-0
}
momentum_discete_results <- backtest(momentum_processed_discrete,momentum_returns)
barplot(momentum_discete_results$leadLag$leadLag, main = "discrete momentum leadlag")
plot.zoo(momentum_discete_results$leadLag$leadLagPnL[,7:9], col = mycols, 
         plot.type = "single", main = "discrete momentum leadlag")
legend("topleft", inset=c(-0,-0), cex=0.6, lty = 1, 
       col = mycols, 
       legend = colnames(momentum_discete_results$leadLag$leadLagPnL[,7:9]) )
daily_pnl <- diff(momentum_discete_results$pnl)
charts.PerformanceSummary(log(daily_pnl/10+1),ylog=TRUE,
                          period.areas = drawdowns.dates,period.color = rgb[1],
                          colorset=c(2,3,4),
                          legend.loc="topleft",
                          main = "Momentum TS PnL" )

chart.RollingMean(log(daily_pnl/10+1), width = 252,
                  legend.loc="topleft")

chart.Histogram(log(daily_pnl/10+1), main = "momentum pnl distribution")

dev.off()
