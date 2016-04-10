require(IKTrading)

currency('USD')
Sys.setenv(TZ="UTC")
from = "1990-01-01"
to = "2016-03-07"
verbose = F

t1 <- Sys.time()
if(!"CME_CL" %in% ls()) {
  #Energies
  CME_wti <- quandClean("CHRIS/CME_CL", start_date=from, end_date=to, verbose=verbose) #Crude
  CME_NG <- quandClean("CHRIS/CME_NG", start_date=from, end_date=to, verbose=verbose) #NatGas
  CME_HO <- quandClean("CHRIS/CME_HO", start_date=from, end_date=to, verbose=verbose) #HeatingOil
  CME_RB <- quandClean("CHRIS/CME_RB", start_date=from, end_date=to, verbose=verbose) #Gasoline
  CME_Brent <- quandClean("CHRIS/CME_BZ", start_date=from, end_date=to, verbose=verbose) #Brent
  CME_Gasoil <- quandClean("CHRIS/CME_WQ", start_date=from, end_date=to, verbose=verbose) #Gasoil
  
  #Grains
  CME_C <- quandClean("CHRIS/CME_C", start_date=from, end_date=to, verbose=verbose) #Chicago Corn
  CME_S <- quandClean("CHRIS/CME_S", start_date=from, end_date=to, verbose=verbose) #Chicago Soybeans
  CME_W <- quandClean("CHRIS/CME_W", start_date=from, end_date=to, verbose=verbose) #Chicago Wheat
  CME_SM <- quandClean("CHRIS/CME_SM", start_date=from, end_date=to, verbose=verbose) #Chicago Soybean Meal
  CME_KW <- quandClean("CHRIS/CME_KW", start_date=from, end_date=to, verbose=verbose) #Kansas City Wheat
  CME_BO <- quandClean("CHRIS/CME_BO", start_date=from, end_date=to, verbose=verbose) #Chicago Soybean Oil
  
  #Softs
  LIFFE_SB <- quandClean("CHRIS/LIFFE_W", start_date=from, end_date=to, verbose=verbose) #Sugar
  LIFFE_RobustaCoffee <- quandClean("CHRIS/LIFFE_RC", start_date=from, end_date=to, verbose=verbose) #Coffee
  LIFFE_C <- quandClean("CHRIS/LIFFE_C", start_date=from, end_date=to, verbose=verbose) #Cocoa

  #Other Ags
  CME_LC <- quandClean("CHRIS/CME_LC", start_date=from, end_date=to, verbose=verbose) #Live Cattle
  CME_LN <- quandClean("CHRIS/CME_LN", start_date=from, end_date=to, verbose=verbose) #Lean Hogs
  
  #Precious Metals
  CME_GC <- quandClean("CHRIS/CME_GC", start_date=from, end_date=to, verbose=verbose) #Gold
  CME_SI <- quandClean("CHRIS/CME_SI", start_date=from, end_date=to, verbose=verbose) #Silver
  CME_PL <- quandClean("CHRIS/CME_PL", start_date=from, end_date=to, verbose=verbose) #Platinum
  CME_PA <- quandClean("CHRIS/CME_PA", start_date=from, end_date=to, verbose=verbose) #Palladium
  
  #Base
  CME_HG <- quandClean("CHRIS/CME_HG", start_date=from, end_date=to, verbose=verbose) #Copper
  
  #Currencies
  CME_AUD <- quandClean("CHRIS/CME_AD", start_date=from, end_date=to, verbose=verbose) #Ozzie
  CME_CAD <- quandClean("CHRIS/CME_CD", start_date=from, end_date=to, verbose=verbose) #Loonie
  CME_EUR <- quandClean("CHRIS/CME_EC", start_date=from, end_date=to, verbose=verbose) #Euro
  CME_CHF <- quandClean("CHRIS/CME_SF", start_date=from, end_date=to, verbose=verbose) #Swiss Franc
  CME_GBP <- quandClean("CHRIS/CME_BP", start_date=from, end_date=to, verbose=verbose) #Cable
  CME_JPY <- quandClean("CHRIS/CME_JY", start_date=from, end_date=to, verbose=verbose) #Yen
  CME_NZD <- quandClean("CHRIS/CME_NE", start_date=from, end_date=to, verbose=verbose) #Kiwi
  USD <- CME_CHF
  USD[,]=1
  
  #Equities
  CME_ES_EQ <- quandClean("CHRIS/CME_ES", start_date=from, end_date=to, verbose=verbose) #Emini
  CME_MD_EQ <- quandClean("CHRIS/CME_MD", start_date=from, end_date=to, verbose=verbose) #Midcap 400
  CME_NQ_EQ <- quandClean("CHRIS/CME_NQ", start_date=from, end_date=to, verbose=verbose) #Nasdaq 100
  CME_NK_EQ <- quandClean("CHRIS/CME_NK", start_date=from, end_date=to, verbose=verbose) #Nikkei
  CME_DX_EQ <- quandClean("CHRIS/EUREX_FDAX", start_date=from, end_date=to, verbose=verbose) #DAX
  CME_SF_EQ <- quandClean("CHRIS/EUREX_FMZA", start_date=from, end_date=to, verbose=verbose) #South Africa
  CME_FTSE_EQ <- quandClean("CHRIS/LIFFE_Z", start_date=from, end_date=to, verbose=verbose) #FTSE
  
  #Dollar Index and Bonds/Rates
  ICE_DX  <- quandClean("CHRIS/CME_DX", start_date=from, end_date=to, verbose=verbose) #Dixie
  CME_FF  <- quandClean("CHRIS/CME_FF", start_date=from, end_date=to, verbose=verbose) #30-day fed funds
  CME_ED  <- quandClean("CHRIS/CME_ED", start_date=from, end_date=to, verbose=verbose) #3 Mo. Eurodollar/TED Spread
  CME_FV  <- quandClean("CHRIS/CME_FV", start_date=from, end_date=to, verbose=verbose) #Five Year TNote
  CME_TY  <- quandClean("CHRIS/CME_TY", start_date=from, end_date=to, verbose=verbose) #Ten Year Note
  CME_US  <- quandClean("CHRIS/CME_US", start_date=from, end_date=to, verbose=verbose) #30 year bond
  
  YIELD_CAN <- read.zoo(Quandl("YC/CAN10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
  YIELD_GER <- read.zoo(Quandl("YC/DEU10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
  YIELD_JPN <- read.zoo(Quandl("YC/JPN10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
  YIELD_USA <- read.zoo(Quandl("YC/USA10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
  YIELD_GBR <- read.zoo(Quandl("YC/GBR10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
  
  source("yield_to_price.R")
  CME_bund  <- yield_to_price(YIELD_GER)
  CME_JGB <- yield_to_price(YIELD_JPN)
  CME_CGB <- yield_to_price(YIELD_CAN)
  CME_GILT <- yield_to_price(YIELD_GBR)
  CME_TY <- yield_to_price(YIELD_USA)
}

mycols <- c("red", "blue", "green", "yellow", "purple", "pink", "black","brown")
CMEinsts <- c("CL", "NG", "HO", "RB", "C", "S", "W", "SM", "KW", "BO", "LC", "LN", "GC", "SI", "PL", 
              "PA", "HG", "AD", "CD", "SF", "EC", "BP", "JY", "NE", "ES", "MD", "NQ", "TF", "NK", #"FF",
              "ED", "FV", "TY", "US")

ICEinsts <- c("B", "G", "SB", "KC", "CC", "CT", "DX")
CME <- paste("CME", CMEinsts, sep="_")
ICE <- paste("ICE", ICEinsts, sep="_")
symbols <- c(CME, ICE)
stock(symbols, currency="USD", multiplier=1)
t2 <- Sys.time()
print(t2-t1)

