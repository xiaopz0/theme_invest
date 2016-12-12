require(IKTrading)
require(Quandl)

#Energies
CME_wti4 <- Quandl("SCF/CME_CL4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Crude
CME_NG4 <- Quandl("SCF/CME_NG4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #NatGas
CME_HO4 <- Quandl("SCF/CME_HO4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #HeatingOil
CME_RB4 <- Quandl("SCF/CME_RB4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoline
ICE_Brent4 <- Quandl("SCF/ICE_B4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Brent
ICE_Gasoil4 <- Quandl("SCF/ICE_G4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoil

#Grains
CME_C4 <- Quandl("SCF/CME_C4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Corn
CME_W4 <- Quandl("SCF/CME_W4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Wheat
CME_KW4 <- Quandl("SCF/CME_KW4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Kansas City Wheat
CME_S4 <- Quandl("SCF/CME_S4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybeans
CME_SM4 <- Quandl("SCF/CME_SM4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Meal
CME_BO4 <- Quandl("SCF/CME_BO4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Oil

#Softs
ICE_SB4 <- Quandl("SCF/ICE_SB4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Sugar
ICE_RobustaCoffee4 <- Quandl("SCF/ICE_KC4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Coffee
ICE_CC4 <- Quandl("SCF/ICE_CC4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa
ICE_CT4 <- Quandl("SCF/ICE_CT4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa

#Other Ags
CME_LC4 <- Quandl("SCF/CME_LC4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Live Cattle
CME_LN4 <- Quandl("SCF/CME_LN4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Lean Hogs

#Precious Metals
CME_GC4 <- Quandl("SCF/CME_GC4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gold
CME_SI4 <- Quandl("SCF/CME_SI4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Silver
CME_PL4 <- Quandl("SCF/CME_PL4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Platinum
CME_PA4 <- Quandl("SCF/CME_PA4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Palladium

#Base
SHFE_CU4 <- Quandl("SCF/SHFE_CU4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper
SHFE_ZN4 <- Quandl("SCF/SHFE_ZN4_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper

