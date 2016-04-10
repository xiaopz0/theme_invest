## example dates
x.Date <- as.Date(paste(2003, 02, c(1, 3, 7, 9, 14), sep = "-"))

## univariate plotting
x <- zoo(rnorm(5), x.Date)
x2 <- zoo(rnorm(5, sd = 0.2), x.Date)
plot(x)
lines(x2, col = 2)

## multivariate plotting
z <- cbind(x, x2, zoo(rnorm(5, sd = 0.5), x.Date))
plot(z, type = "b", pch = 1:3, col = 1:3, ylab = list(expression(mu), "b", "c"))
colnames(z) <- LETTERS[1:3]
plot(z, screens = 1, col = list(B = 2))
plot(z, type = "b", pch = 1:3, col = 1:3)
plot(z, type = "b", pch = list(A = 1:5, B = 3), col = list(C = 4, 2))
plot(z, type = "b", screen = c(1,2,1), col = 1:3)
# right axis is for broken lines
plot(x)
opar <- par(usr = c(par("usr")[1:2], range(x2)))
lines(x2, lty = 2)
# axis(4)
axis(side = 4)
par(opar)


#open libraries 
library(xts)
library(zoo)
#set some random variables
a=rnorm(100)
b=rnorm(100)
#and some time series
c=seq(as.Date("2000/1/1"), by = "week", length.out = 100)
d=cbind(a,b)
#make it into an zoo object
d=as.zoo(d, order.by=c)
plot.zoo(d, 
         plot.type = "single", 
         col = c("red", "blue"))


require(devtools) 
install.packages("FinancialInstrument", repos="http://R-Forge.R-project.org") 
library(PerformanceAnalytics)
install.packages("blotter", repos="http://R-Forge.R-project.org") 
install.packages("quantstrat", repos="http://R-Forge.R-project.org") 
install.packages("foreach") 
install_github("IlyaKipnis/IKTrading") 


## for each index value in x merge it with the closest index value in y
## but retaining x's times.
x<-zoo(1:3,as.Date(c("1992-12-13", "1997-05-12", "1997-07-13")))
y<-zoo(1:5,as.Date(c("1992-12-15", "1992-12-16", "1997-05-10","1997-05-19", "1997-07-13")))
f <- function(u) which.min(abs(as.numeric(index(y)) - as.numeric(u)))
ix <- sapply(index(x), f)
cbind(x, y = coredata(y)[ix])

## this merges each element of x with the closest time point in y at or
## after x's time point (whereas in previous example it could be before
## or after)
window(na.locf(merge(x, y), fromLast = TRUE), index(x))

## example time series:
set.seed(0)
flow <- ts(filter(rlnorm(200, mean = 1), 0.8, method = "r"))

## highlight values above and below thresholds.
## this draws on top using semi-transparent colors.
rgb <- hcl(c(0, 0, 260), c = c(100, 0, 100), l = c(50, 90, 50), alpha = 0.3)
plot(flow)
xblocks(flow > 30, col = rgb[1]) ## high values red
xblocks(flow < 15, col = rgb[3]) ## low value blue
xblocks(flow >= 15 & flow <= 30, col = rgb[2]) ## the rest gray

## same thing:
plot(flow)
xblocks(time(flow), cut(flow, c(0,15,30,Inf), labels = rev(rgb)))

## another approach is to plot blocks underneath without transparency.
plot(flow)
## note that 'ifelse' keeps its result as class 'ts'
xblocks(ifelse(flow < mean(flow), hcl(0, 0, 90), hcl(0, 80, 70)))
## need to redraw data series on top:
lines(flow)
box()

## for single series only: plot.default has a panel.first argument
plot(time(flow), flow, type = "l",
     panel.first = xblocks(flow > 20, col = "lightgray"))
## (see also the 'panel' argument for use with multiple series, below)

## insert some missing values
flow[c(1:10, 50:80, 100)] <- NA

## the default plot shows data coverage
## (most useful when displaying multiple series, see below)
plot(flow)
xblocks(flow)

## can also show gaps:
plot(flow, type = "s")
xblocks(time(flow), is.na(flow), col = "gray")

## Example of alternating colors, here showing calendar months
flowdates <- as.Date("2000-01-01") + as.numeric(time(flow))
flowz <- zoo(coredata(flow), flowdates)
plot(flowz)
xblocks(flowz, months, ## i.e. months(time(flowz)),
        col = gray.colors(2, start = 0.7), border = "slategray")
lines(flowz)

## Example of multiple series.
## set up example data
z <- ts(cbind(A = 0:5, B = c(6:7, NA, NA, 10:11), C = c(NA, 13:17)))

## show data coverage only (highlighting gaps)
plot(z, panel = function(x, ...)
  xblocks(x, col = "darkgray"))

## draw gaps in darkgray
plot(z, type = "s", panel = function(x, ...) {
  xblocks(time(x), is.na(x), col = "darkgray")
  lines(x, ...); points(x)
})

## Example of overlaying blocks from a different series.
## Are US presidential approval ratings linked to sunspot activity?
## Set block height to plot blocks along the bottom.
plot(presidents)
xblocks(sunspot.year > 50, height = 2)
require(quantmod)
require(PerformanceAnalytics)  

data(edhec)
findDrawdowns(edhec[,"Funds of Funds", drop=FALSE])
sortDrawdowns(findDrawdowns(edhec[,"Funds of Funds", drop=FALSE]))

data(edhec)
chart.Drawdown(edhec[,c(1,2)],
               main="Drawdown from Peak Equity Attained",
               legend.loc="bottomleft")
