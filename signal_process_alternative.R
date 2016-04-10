signal_process_alternative <- function(raw_signal, returns){
  processed_signal <- raw_signal
  processed_signal[,] <- NA
  raw_date <- time(raw_signal)
  return_date <- time(returns)
  for(i in 1:length(raw_date)){
    idate <- raw_date[i]
    date_ind <- which(return_date %in% idate)
    rolling_returns <- returns[(date_ind-252):date_ind,]
    rolling_returns[is.na(rolling_returns)] <- 0                         
    rolling_asset_cov <- cov(rolling_returns, use = "pairwise.complete.obs")
    raw_signal_date <- raw_signal[idate,]
    non_nan_index <- (!is.na(raw_signal_date)) & (!is.na(returns[idate,]))
    if(sum(non_nan_index)>=1){
      processed_rank <- as.numeric(raw_signal_date)
      processed_cov <- rolling_asset_cov[non_nan_index,non_nan_index]
      processed_vol <- sqrt(252*processed_rank %*% as.matrix(rolling_asset_cov[non_nan_index,non_nan_index]) %*% processed_rank)
      processed_signal[idate,non_nan_index] <- processed_rank / processed_vol
    }
  }
  return(processed_signal)
}