simple_rolling_mean <- function(x, window=252){
  res <- x
  res[] <- NA
  mydate <- time(x)
  if(window<length(mydate)){
    for(i in window:length(mydate)){
      res[i] <- mean(x[(i-window+1):i], na.rm = T)
    }
  }
  return(res)
}