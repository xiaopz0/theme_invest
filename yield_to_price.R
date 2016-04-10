yield_to_price <- function(yields){
  prices <- yields
  prices[] = NA
  prices[1] <- 100
  for(i in 2:length(yields)){
    coupon_rate = as.numeric(yields[i-1])
    yield = as.numeric(yields[i])/100
    price <- 100 / ((1 + yield)^10)
    for(j in 1:10){
      price <- price + coupon_rate / ((1 + yield)^(j))
    }
    prices[i] = prices[i-1] +(price-100)
  }
  return(prices)
}