join.zoo <- function(zoo_a,zoo_b,sdate=0,edate=0){
  my_date = as.Date(union(time(zoo_a), time(zoo_b)))
  if(sdate>0){my_date<-my_date[my_date>sdate]}
  if(edate>0){my_date<-my_date[my_date<edate]}
  zoo_join <- merge(zoo_a,zoo_b)
  zoo_join <- na.locf(zoo_join)
  return(zoo_join[my_date,])
}