require(IKTrading)
require(Quandl)

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

