backtest <- function(exposure, returns, lag=-1, discrete = F, price = 0){
  if(discrete){
    asset <- intersect(colnames(exposure), colnames(price))
    exposure[,asset] <- exposure[,asset] * price[,asset]
  }
  res <- calcIR(exposure, returns, lag)
  res$leadLag <- leadLag(exposure, returns)
  plot.zoo(res$asset_pnl, plot.type = "multiple", 
           main = "Asset Performance")
  plot.zoo(res$asset_pnl, plot.type = "single", 
           col = c("red", "blue", "green", "yellow", "purple", 
                   "pink", "black","brown"), 
           main = "Asset Performance")
  legend("topleft", inset=c(-0.03,0), 
         legend=colnames(res$asset_pnl), lty = 1, 
         col = mycols, cex=0.6) 
  return(res)
}

leadLag <- function(exposure, returns){
  leadLag <- zoo(-5:20,-5:20)
  lags <- -5:20
  leadLagPnL <- zoo(matrix(0,length(time(returns)),26), 
                    order.by = time(returns))
  for(i in 1:26){
    backtest_results <- calcIR(exposure, returns, -lags[i])
    leadLag[i] <- as.numeric(backtest_results$IR)
    PnL <- backtest_results$pnl
    date_fill <- which(time(leadLagPnL) %in% time(PnL))
    leadLagPnL[date_fill,i] <- as.numeric(PnL)
  }
  colnames(leadLagPnL) <- lags
  res <- list()
  res$leadLag <- leadLag
  res$leadLagPnL <- leadLagPnL
  return(res)
}

calcIR <- function(exposure, returns, lag=-1){
  pnl_results <- calcPnL(exposure, returns, lag)
  pnl <- pnl_results$pnl
  pnl_results$IR <- pnl[length(pnl)] / sqrt(var(diff(pnl))) / 
    length(pnl) * sqrt(252)
  return(pnl_results)
}

calcPnL <- function(exposure, returns, lag=-1){
  exposure <- lag(exposure,lag)
  #common_date <- as.Date(intersect(time(exposure), time(returns)))
  asset_pnl <- exposure * returns
  for(asset in colnames(asset_pnl)){
    asset_pnl[,asset] <- exposure[,asset] * returns[,asset]
  }
  remove_na <- function(x){x[is.na(x)]<-0; return(x)}
  asset_pnl <- as.zoo(apply(asset_pnl, 2, remove_na), time(asset_pnl))
  asset_pnl <- cumsum(asset_pnl)
  res = list()
  res$asset_pnl <- asset_pnl
  res$pnl <- zoo(rowSums(asset_pnl,na.rm = T), time(asset_pnl))
  return(res)
}