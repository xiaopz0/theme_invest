backtest <- function(exposure, returns, lag=-1){
  res <- calcPnL(exposure, returns, lag)
  plot.zoo(res$asset_pnl, plot.type = "multiple", main = "Asset Performance")
  plot.zoo(res$asset_pnl, plot.type = "single", col = c("red", "blue", "green", "yellow", "purple", "pink", "black","brown"), main = "Asset Performance")
  legend("topright", inset=c(-0.03,0), legend=colnames(res$asset_pnl), lty = 1, col = mycols,cex=0.6)
  return(res)
}

leadLag <- function(exposure, returns){
  leadLag <- zoo(-5:20,-5:20)
  for(i in 1:26){
    leadLag[i] <- as.numeric(calcIR(exposure, returns, as.numeric(-leadLag[i])))
  }
  return(leadLag)
}

calcIR <- function(exposure, returns, lag=-1){
  exposure <- lag(exposure,lag)
  common_date <- as.Date(intersect(time(exposure), time(returns)))
  asset_pnl <- exposure[common_date] * returns[common_date]
  remove_na <- function(x){x[is.na(x)]<-0; return(x)}
  asset_pnl <- as.zoo(apply(asset_pnl, 2, remove_na), time(asset_pnl))
  asset_pnl <- cumsum(asset_pnl)
  pnl <- zoo(rowSums(asset_pnl), time(asset_pnl))
  IR <- pnl[length(pnl)] / sqrt(var(diff(pnl))) / length(pnl) * sqrt(252)
  return(IR)
}

calcPnL <- function(exposure, returns, lag=-1){
  exposure <- lag(exposure,lag)
  common_date <- as.Date(intersect(time(exposure), time(returns)))
  asset_pnl <- exposure[common_date] * returns[common_date]
  remove_na <- function(x){x[is.na(x)]<-0; return(x)}
  asset_pnl <- as.zoo(apply(asset_pnl, 2, remove_na), time(asset_pnl))
  asset_pnl <- cumsum(asset_pnl)
  pnl <- zoo(rowSums(asset_pnl), time(asset_pnl))
  res = list()
  res$asset_pnl <- asset_pnl
  res$pnl <- pnl
  res$IR <- calcIR(exposure, returns, -1)
  res$leadLag <- leadLag(exposure, returns)
  return(res)
}