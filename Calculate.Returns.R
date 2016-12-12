
Extract.Returns <- function(returns_){
  if("Date" %in% colnames(returns_)){
    dates <- returns_$Date
  }else {
    dates <- as.Date(rownames(returns_))
  }
  if("Last" %in% colnames(returns_)){
    returns <- log(zoo(returns_$Last+1, order.by = dates))
  }else {
    returns <- log(zoo(returns_$Settle+1, order.by = dates))
  }
  returns[ is.na(returns) ] <- 0
  returns[ is.infinite(returns) ] <- 0
  return(returns)
}

Extract.Price <- function(price_){
  if("Date" %in% colnames(price_)){
    dates <- price_$Date
  }else {
    dates <- as.Date(rownames(price_))
  }
  if("Last" %in% colnames(price_)){
    price <- zoo(price_$Last, order.by = dates)
  }else {
    price <- zoo(price_$Settle, order.by = dates)
  }
  price[ is.na(price) ] <- 0
  price[ is.infinite(price) ] <- 0
  return(price)
}

Calculate.Returns.list <- function(asset){
  for(i in 1:4){
    if(i == 1){
      list_returns <- Calculate.Returns(eval(parse(text = asset)))
    } else {
      if(exists(paste(asset,i, sep=""))){
        list_returns <- merge(list_returns, 
            Calculate.Returns(eval(parse(text = paste(asset,i, sep="")))))
      }
    }
  }
  return(list_returns)
}

Extract.Returns.list <- function(asset){
  for(i in 1:4){
    if(i == 1){
      list_returns <- Extract.Returns(eval(parse(text = asset)))
    } else {
      if(exists(paste(asset,i, sep=""))){
        list_returns <- merge(list_returns, 
                              Extract.Returns(eval(parse(text = paste(asset,i, sep="")))))
      }
    }
  }
  return(list_returns)
}

Calculate.Raw <- function(list_returns){
  if(is.null(dim(list_returns))){
    return( list_returns - list_returns)
  }
  else if(dim(list_returns)[2]==3){
    return( list_returns[,1] - rowMeans(list_returns[,2:3], na.rm = T))
  }
  else if(dim(list_returns)[2]== 2){
    return( list_returns[,1] - list_returns[,2])
  }
  else if(dim(list_returns)[2]==4){
    return( list_returns[,1] - rowMeans(list_returns[,2:4], na.rm = T))
  }
}