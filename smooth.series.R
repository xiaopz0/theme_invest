require(SDMTools)

smooth.series <- function(tseries, window = 176, half_life = 44){
  num_dates <- dim(tseries)[1] # assuming date is the first dimension
  if(half_life == 0){ # no exponential smoothing
    if (window == 0){ # no moving average smoothing
      rolmean <- tseries
    } else{
      rolmean <- tseries
      for(i in 2:num_dates){
        start_point <- max(1,i-1-window)
        rolmean[i,] <- colMeans(tseries[start_point:(i-1),])
      }
    }
    } else {
      weights <- ((0.5)^(1/half_life))^(num_dates:1)
      rolmean <- tseries
      for(i in 2:num_dates){
        start_point <- max(1,i-window-1)
        rol_window <- i - start_point
        rolmean[i,] <- weighted.means(tseries[start_point:(i-1),], weights[1:rol_window])
      }
    }
  return(rolmean)
}

weighted.means <- function(tseries, weights){
  na.omit(tseries)
  if(is.null(dim(tseries))){return(tseries)}
  else{
    tseries_copy <- tseries[1,]
    num_tseries <- dim(tseries)[2]
    for(i in 1:num_tseries){
      data_index <- !is.na(tseries[,i])
      # set the data to 0 if less than a half of data is non nan
      tseries_copy[i] <- 0
      if(sum(data_index)<length(data_index)/2){   
      }else{
        tmp_weights <- weights[data_index]
        tmp_data <- tseries[data_index,i]
        tseries_copy[i] <- weighted.mean(tmp_data, tmp_weights)
      }
    }
    return(tseries_copy)
  }
}

weighted.vol <- function(tseries, weights){
  if(is.null(dim(tseries))){return(tseries)}
  else{
    tseries_copy <- tseries[1,]
    num_tseries <- dim(tseries)[2]
    for(i in 1:num_tseries){
      data_index <- !is.na(tseries[,i])
      if(sum(data_index)<length(data_index)/2){ 
        tseries_copy[i] <- NA
      }
      else{
        tmp_weights <- weights[data_index]
        tmp_data <- tseries[data_index,i]
        tseries_copy[i] <- wt.sd(tmp_data, tmp_weights)
      }
    }
    return(tseries_copy)
  }
}

Calculate.Score <- function(tseries, mean_window = 0, std_window = 3024, std_half_life = 756){
  num_dates <- dim(tseries)[1] # assuming date is the first dimension
  if(mean_window==0){rol_mean=0} #no demean
  else{
    rol_mean <- smooth.series(tseries, window = mean_window, half_life = 0)
  }
  weights <- ((0.5)^(1/std_half_life))^(num_dates:1)
  rolvol <- tseries
  rolvol[,] <- 0
  for(i in 2:num_dates){
    start_point <- max(1,i-1-std_window)
    rol_window <- i - start_point
    rolvol[i,] <- weighted.vol(tseries[start_point:(i-1),], weights[1:rol_window])
  }
  score = tseries - rol_mean
  score = score %/% rolvol
  # remove infinity
  for(i in 1:dim(score)[2]){
    score[is.infinite(score[,i]),i]<-0
  }
  # remove outliers
  for(i in 1:dim(score)[2]){
    score[score[,i]>3,i]=3
    score[score[,i]< -3,i]=-3
  }
  return(score)
}