
eam_sp.model <-eam.ret(gspc,10,200)
plot.zoo(eam.model, plot.type = "single", col = c("red", "blue"))

eam_wti.model <-eam.ret(wti,10,200)
plot.zoo(eam_wti.model, plot.type = "single", col = c("red", "blue"))

currencies <- list(CME_AUD,CME_CAD,CME_CHF,CME_EUR,CME_GBP,CME_JPY,CME_NZD)

for(i in 1:length(currencies)){
  eam_wti.model <-eam.ret(currencies[[i]],10,200)
  plot.zoo(eam_wti.model, plot.type = "single", col = c("red", "blue"))
}