require(IKTrading)
require(Quandl)

#Energies
CME_wti3 <- Quandl("SCF/CME_CL3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Crude
CME_NG3 <- Quandl("SCF/CME_NG3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #NatGas
#CME_HO3 <- Quandl("SCF/CME_HO3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #HeatingOil
CME_HO3 <- quandCleanReturn("CHRIS/CME_HO", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #HeatingOil

#CME_RB3 <- Quandl("SCF/CME_RB3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoline
CME_RB3 <- quandCleanReturn("CHRIS/CME_RB", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Gasoline
#ICE_Brent3 <- Quandl("SCF/ICE_B3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Brent
ICE_Brent3 <- quandCleanReturn("CHRIS/CME_RB", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Gasoline
ICE_Gasoil3 <- Quandl("SCF/ICE_G3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gasoil

#Grains
CME_C3 <- Quandl("SCF/CME_C3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Corn
CME_W3 <- Quandl("SCF/CME_W3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Wheat
#CME_KW3 <- Quandl("SCF/CME_KW3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Kansas City Wheat
CME_KW3 <- quandCleanReturn("CHRIS/CME_KW", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Kansas City Wheat

CME_S3 <- Quandl("SCF/CME_S3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybeans
#CME_SM3 <- Quandl("SCF/CME_SM3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Meal
CME_SM3 <- quandCleanReturn("CHRIS/CME_SM", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Chicago Soybean Meal
#CME_BO3 <- Quandl("SCF/CME_BO3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Chicago Soybean Oil
CME_BO3 <- quandCleanReturn("CHRIS/CME_BO", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Chicago Soybean Oil

#Softs
#ICE_SB3 <- Quandl("SCF/ICE_SB3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Sugar
ICE_SB3 <- quandCleanReturn("CHRIS/ICE_SB", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Sugar
#ICE_RobustaCoffee3 <- Quandl("SCF/ICE_KC3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Coffee
ICE_RobustaCoffee3 <- quandCleanReturn("CHRIS/LIFFE_RC", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Coffee
#ICE_CC3 <- Quandl("SCF/ICE_CC3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cocoa
ICE_CC3 <- quandCleanReturn("CHRIS/LIFFE_C", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Cocoa
#ICE_CT3 <- Quandl("SCF/ICE_CT3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Cotton
ICE_CT3 <- quandCleanReturn("CHRIS/ICE_CT", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Cotton

#Other Ags
#CME_LC3 <- Quandl("SCF/CME_LC3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Live Cattle
CME_LC3 <- quandCleanReturn("CHRIS/CME_LC", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Live Cattle
#CME_LN3 <- Quandl("SCF/CME_LN3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Lean Hogs
CME_LN3 <- quandCleanReturn("CHRIS/CME_LN", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Lean Hogs

#Precious Metals
#CME_GC3 <- Quandl("SCF/CME_GC3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Gold
CME_GC3 <- quandCleanReturn("CHRIS/CME_GC", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Gold
#CME_SI3 <- Quandl("SCF/CME_SI3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Silver
CME_SI3 <- quandCleanReturn("CHRIS/CME_SI", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Silver
#CME_PL3 <- Quandl("SCF/CME_PL3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Platinum
#CME_PL3 <- quandCleanReturn("CHRIS/CME_PL", api_key="QwpBL4SFTYUEYH3qsWHs", contract=3) #Platinum
#CME_PA3 <- Quandl("SCF/CME_PA3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Palladium

#Base
#SHFE_CU3 <- Quandl("SCF/SHFE_CU3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper
#SHFE_ZN3 <- Quandl("SCF/SHFE_ZN3_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Copper

