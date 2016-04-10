real_exchange_rate <- function(CPI,Exchange_rate,sdate=0,edate=0){
  joined_data <- join.zoo(CPI, Exchange_rate,sdate,edate)
  my_date = time(joined_data)
  if(sdate>0){my_date<-my_date[my_date>sdate]}
  if(edate>0){my_date<-my_date[my_date<edate]}
  joined_data <- joined_data[my_date,]
  CPI_adjusted <- joined_data[,1]
  CPI_adjusted <- CPI_adjusted/as.numeric(CPI_adjusted[1])
  nominal_exchange_rate <- joined_data[,2]
  real_exchange_rate <- nominal_exchange_rate/CPI_adjusted
  return(real_exchange_rate)
}