require(IKTrading)
require(Quandl)

currency('USD')
Sys.setenv(TZ="UTC")
from = "1990-01-01"
to = "2016-03-07"
verbose = F

t1 <- Sys.time()
#Energies
CME_wti <- Quandl("SCF/CME_CL1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Crude
CME_NG <- Quandl("SCF/CME_NG1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #NatGas
CME_HO <- Quandl("SCF/CME_HO1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #HeatingOil
CME_RB <- Quandl("SCF/CME_RB1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoline
ICE_Brent <- Quandl("SCF/ICE_B1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Brent
ICE_Gasoil <- Quandl("SCF/ICE_G1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoil

#Grains
CME_C <- Quandl("SCF/CME_C1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Corn
CME_W <- Quandl("SCF/CME_W1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Wheat
CME_KW <- Quandl("SCF/CME_KW1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Kansas City Wheat
CME_S <- Quandl("SCF/CME_S1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybeans
CME_SM <- Quandl("SCF/CME_SM1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Meal
CME_BO <- Quandl("SCF/CME_BO1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Oil

#Softs
ICE_SB <- Quandl("SCF/ICE_SB1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Sugar
ICE_RobustaCoffee <- Quandl("SCF/ICE_KC1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Coffee
ICE_CC <- Quandl("SCF/ICE_CC1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa
ICE_CT <- Quandl("SCF/ICE_CT1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa

#Other Ags
CME_LC <- Quandl("SCF/CME_LC1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Live Cattle
CME_LN <- Quandl("SCF/CME_LN1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Lean Hogs

#Precious Metals
CME_GC <- Quandl("SCF/CME_GC1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gold
CME_SI <- Quandl("SCF/CME_SI1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Silver
CME_PL <- Quandl("SCF/CME_PL1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Platinum
CME_PA <- Quandl("SCF/CME_PA1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Palladium

#Base
SHFE_CU <- Quandl("SCF/SHFE_CU1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper
SHFE_ZN <- Quandl("SCF/SHFE_ZN1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper

#Currencies
CME_AUD <- Quandl("SCF/CME_AD1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Ozzie
CME_CAD <- Quandl("SCF/CME_CD1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Loonie
CME_EUR <- Quandl("SCF/CME_EC1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Euro
CME_CHF <- Quandl("SCF/CME_SF1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Swiss Franc
ICE_GBP <- Quandl("SCF/ICE_MP1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cable
CME_JPY <- Quandl("SCF/CME_JY1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Yen
CME_NZD <- Quandl("SCF/CME_NE1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Kiwi
USD <- CME_CHF
USD[,2:dim(USD)[2]]=0

#Equities
CME_ES_EQ <- Quandl("SCF/CME_SP1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Emini
CME_MD_EQ <- Quandl("SCF/CME_MD1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Midcap 400
CME_NQ_EQ <- Quandl("SCF/CME_NQ1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Nasdaq 100
CME_NK_EQ <- Quandl("SCF/CME_NK1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Nikkei
CME_DX_EQ <- Quandl("SCF/EUREX_FDAX1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #DAX
#CME_SF_EQ <- Quandl("SCF/EUREX_FDAX1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #South Africa
CME_FTSE_EQ <- Quandl("SCF/LIFFE_Z1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #FTSE

#Dollar Index and Bonds/Rates
#ICE_DX  <- quandClean("CHRIS/CME_DX", start_date=from, end_date=to, verbose=verbose) #Dixie
CME_FF  <- Quandl("SCF/CME_FF1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #30-day fed funds
CME_ED  <- Quandl("SCF/CME_ED1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #3 Mo. Eurodollar/TED Spread
CME_FV  <- Quandl("SCF/CME_FV1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Five Year TNote

CME_TY  <- Quandl("SCF/CME_TY1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #US Ten Year Note
#CME_CD  <- Quandl("SCF/CME_CD1_ER", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Ten Year Note
CME_bund  <- Quandl("SCF/EUREX_FGBL1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Bund Ten Year Note
CME_GILT  <- Quandl("SCF/LIFFE_R1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gilt Ten Year Note

YIELD_CAN <- read.zoo(Quandl("YC/CAN10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
YIELD_GER <- read.zoo(Quandl("YC/DEU10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
YIELD_JPN <- read.zoo(Quandl("YC/JPN10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
YIELD_USA <- read.zoo(Quandl("YC/USA10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")
YIELD_GBR <- read.zoo(Quandl("YC/GBR10Y", api_key="QwpBL4SFTYUEYH3qsWHs"), format = "%Y-%m-%d")

source("yield_to_price.R")
#CME_bund  <- yield_to_price(YIELD_GER)
#CME_JGB <- yield_to_price(YIELD_JPN)
#CME_CGB <- yield_to_price(YIELD_CAN)
#CME_GILT <- yield_to_price(YIELD_GBR)
#CME_TY <- yield_to_price(YIELD_USA)

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