source("real_exchange_rate.R")
source("join.zoo.R")
source("signal_process_alternative.R")

sdate = "1990-01-01"
edate = "2016-03-07"

pdf("momentum_equities_alternative.pdf")
par(xpd=TRUE)

#equities
equity_list = c("Emini","Midcap","Nasdaq","Nikkei","DAX")
equities <- merge(CME_ES_EQ$Close,CME_MD_EQ$Close,CME_NQ_EQ$Close,CME_NK_EQ$Close,CME_DX_EQ$Close)
colnames(equities) <- equity_list

plot.zoo(equities, plot.type = "multiple", main = "equity_price")
plot.zoo(equities, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black"), main = "equity_price")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

one_year_SMA <- function(x){return(SMA(x,252))}

equity_return <- na.omit(diff(log(equities)))
equity_momentum_raw <- zoo(apply(equity_return,2,one_year_SMA), time(equity_return))
equity_momentum_raw <- equity_momentum_raw[253:dim(equity_momentum_raw)[1],]

plot.zoo(equity_momentum_raw, plot.type = "multiple", main = "Raw Signal")
plot.zoo(equity_momentum_raw, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Raw Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_momentum_processed <- signal_process_alternative(equity_momentum_raw,equity_return)
plot.zoo(equity_momentum_processed, plot.type = "multiple", main = "Processed Signal")
plot.zoo(equity_momentum_processed, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Processed Signal")
legend("topright", inset=c(-0.03,0), legend=equity_list, lty = 1, col = mycols,cex=0.6)

equity_return[abs(equity_return[,4])>0.2,4]<-0
equity_momentum_res <- backtest(equity_momentum_processed,equity_return)
plot.zoo(equity_momentum_res$pnl, main = "Momentum Equity Performance")
barplot(equity_momentum_res$leadLag, main = "Momentum Equity Lead Lag Analysis")

dev.off()

