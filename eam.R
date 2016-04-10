# load packages
library(TTR)
library(zoo)
library(quantmod)

# download daily S&P 500 prices from Jan 1st, 1970 forward
gspc <-getSymbols('^gspc',from='1970-01-01',auto.assign=FALSE)
wti <- Quandl("SCF/ICE_T1_OB", api_key="QwpBL4SFTYUEYH3qsWHs", start_date="2006-01-01", end_date="2016-03-07")
wti <- read.zoo(wti, format = "%Y-%m-%d")
Close = wti[,"Open"]
wti <- cbind(wti,Close)

# error adjusted momentum function
eam <-function(x,y,z) { # x=ticker, y=lookback period for forecast z=SMA period
  a <-na.omit(ROC(Cl(x),1,"discrete"))
  b <-na.omit(SMA(a,y)) # forecast based on "y" trailing period returns
  c <-na.omit(Lag(b,k=1)) # lag forecasts by 1 period
  d <-na.omit(cbind(c,a)) # combine lagged forecasts with actual returns into one file
  e <-as.xts(apply(d,1,diff)) # actual daily return less forecast
  f <-to.daily(na.omit(rollapplyr(e,y,function(x) mean(abs(x)))),drop.time=TRUE,OHLC=FALSE) # mean absolute error
  g <-cbind(a,f) # combine actual return with MAE into one file
  h <-na.omit(a[,1]/g[,2]) # divide actual return by MAE
  i <-na.omit(SMA(h,z)) # generate 200-day moving average of adjusted return
  j <-na.omit(Lag(ifelse(i >0,1,0))) # lag adjusted return signal by one day for trading analysis
}


# function to generate raw EAM signal data
eam.ret <-function(x,y,z) { # x=ticker, y=lookback period for vol forecast, z=SMA period
  a <-eam(x,y,z)
  b <-na.omit(ROC(Cl(x),1,"discrete"))
  
  c <-length(a)-1
  d <-tail(b,c)
  e <-d*a
  f <-cumprod(c(100,1 + e))
  
  g <-tail(b,c)
  h <-cumprod(c(100,1 + g))
  
  i <-cbind(f,h)
  colnames(i) <-c("model","asset")
  
  date.a <-c((first(tail((as.Date(index(x))),c))-1),(tail((as.Date(index(x))),c)))
  
  j <-xts(i,date.a)
  
  return(j)
  
}

eam_sp.model <-eam.ret(gspc,10,200)
plot.zoo(eam.model, plot.type = "single", col = c("red", "blue"))

eam_wti.model <-eam.ret(wti,10,200)
plot.zoo(eam_wti.model, plot.type = "single", col = c("red", "blue"))

eam.data <-function(x,y,z) { # x=ticker, y=lookback period for forecast z=SMA period
  a <-na.omit(ROC(Cl(x),1,"discrete"))
  b <-na.omit(SMA(a,y)) # forecast based on "y" trailing period returns
  c <-na.omit(Lag(b,k=1))  # lag forecasts by 1 period
  d <-na.omit(cbind(c,a))
  e <-as.xts(apply(d,1,diff))
  f <-to.daily(na.omit(rollapplyr(e,y,function(x) mean(abs(x)))),drop.time=TRUE,OHLC=FALSE)
  g <-cbind(a,f)
  h <-na.omit(a[,1]/g[,2])
  i <-na.omit(SMA(h,z))
  colnames(i) <-c("eam data")
  return(i)
}

eam.data.history <-eam.data(gspc,10,200)
plot.zoo(eam.data.history, plot.type = "single", col = c("red", "blue"))

