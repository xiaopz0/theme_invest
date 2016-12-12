require(IKTrading)
require(Quandl)
source("quandCleanReturn.R")
#Energies
CME_wti2 <- Quandl("SCF/CME_CL2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Crude
CME_NG2 <- Quandl("SCF/CME_NG2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #NatGas
CME_HO2 <- Quandl("SCF/CME_HO2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #HeatingOil
CME_RB2 <- Quandl("SCF/CME_RB2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoline
ICE_Brent2 <- Quandl("SCF/ICE_B2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Brent
ICE_Gasoil2 <- Quandl("SCF/ICE_G2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoil

#Grains
CME_C2 <- Quandl("SCF/CME_C2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Corn
CME_W2 <- Quandl("SCF/CME_W2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Wheat
CME_KW2 <- Quandl("SCF/CME_KW2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Kansas City Wheat
CME_S2 <- Quandl("SCF/CME_S2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybeans
CME_SM2 <- Quandl("SCF/CME_SM2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Meal
CME_BO2 <- Quandl("SCF/CME_BO2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Oil

#Softs
ICE_SB2 <- Quandl("SCF/ICE_SB2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Sugar
ICE_RobustaCoffee2 <- Quandl("SCF/ICE_KC2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Coffee
#ICE_CC2 <- Quandl("SCF/ICE_CC2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa
ICE_CC2 <- quandCleanReturn("CHRIS/ICE_CC", api_key="QwpBL4SFTYUEYH3qsWHs", contract=2) #Cocoa
ICE_CT2 <- Quandl("SCF/ICE_CT2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa

#Other Ags
CME_LC2 <- Quandl("SCF/CME_LC2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Live Cattle
CME_LN2 <- Quandl("SCF/CME_LN2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Lean Hogs

#Precious Metals
CME_GC2 <- Quandl("SCF/CME_GC2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gold
#CME_SI2 <- Quandl("SCF/CME_SI2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Silver
CME_SI2 <- quandCleanReturn("CHRIS/CME_SI", api_key="QwpBL4SFTYUEYH3qsWHs", contract=2) #Silver
#CME_PL2 <- Quandl("SCF/CME_PL2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Platinum
CME_PL2 <- quandCleanReturn("CHRIS/CME_PL", api_key="QwpBL4SFTYUEYH3qsWHs", contract=2) #Platinum
#CME_PA2 <- Quandl("SCF/CME_PA2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Palladium
#CME_PA2 <- quandCleanReturn("CHRIS/CME_PA", api_key="QwpBL4SFTYUEYH3qsWHs", contract=2) #Palladium

#Base
SHFE_CU2 <- Quandl("SCF/SHFE_CU2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper
SHFE_ZN2 <- Quandl("SCF/SHFE_ZN2_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper

