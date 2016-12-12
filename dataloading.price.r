require(IKTrading)
require(Quandl)
source('minimum_trade_size')
source('Calculate.Returns.R')

currency('USD')
Sys.setenv(TZ="UTC")
from = "1990-01-01"
to = "2016-03-07"
verbose = F

t1 <- Sys.time()
#Energies
CME_wti_price <- CME_wti_size * Extract.Price(Quandl("SCF/CME_CL1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Crude 
CME_NG_price <- CME_NG_size * Extract.Price(Quandl("SCF/CME_NG1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #NatGas
CME_HO_price <- CME_HO_size * Extract.Price(Quandl("SCF/CME_HO1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #HeatingOil
CME_RB_price <- CME_RB_size * Extract.Price(Quandl("SCF/CME_RB1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Gasoline
ICE_Brent_price <- CME_RB_size * Extract.Price(Quandl("SCF/ICE_B1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Brent
ICE_Gasoil_price <- ICE_Gasoil_size * Extract.Price(Quandl("SCF/ICE_G1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Gasoil

#Grains
CME_C_price <- CME_C_size * Extract.Price(Quandl("SCF/CME_C1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Chicago Corn
CME_W_price <- CME_W_size * Extract.Price(Quandl("SCF/CME_W1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Chicago Wheat
CME_KW_price <- CME_KW_size * Extract.Price(Quandl("SCF/CME_KW1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Kansas City Wheat
CME_S_price <- CME_S_size * Extract.Price(Quandl("SCF/CME_S1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Chicago Soybeans
CME_SM_price <- CME_SM_size * Extract.Price(Quandl("SCF/CME_SM1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Chicago Soybean Meal
CME_BO_price <- CME_BO_size * Extract.Price(Quandl("SCF/CME_BO1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Chicago Soybean Oil

#Softs
ICE_SB_price <- ICE_SB_size * Extract.Price(Quandl("SCF/ICE_SB1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Sugar
ICE_RobustaCoffee_price <- ICE_RobustaCoffee_size * Extract.Price(Quandl("SCF/ICE_KC1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Coffee
ICE_CC_price <- ICE_CC_size * Extract.Price(Quandl("SCF/ICE_CC1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Cocoa
ICE_CT_price <- ICE_CT_size * Extract.Price(Quandl("SCF/ICE_CT1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Cocoa

#Other Ags
CME_LC_price <- CME_LC_size * Extract.Price(Quandl("SCF/CME_LC1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Live Cattle
CME_LN_price <- CME_LN_size * Extract.Price(Quandl("SCF/CME_LN1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Lean Hogs

#Precious Metals
CME_GC_price <- CME_GC_size * Extract.Price(Quandl("SCF/CME_GC1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Gold
CME_SI_price <- CME_SI_size * Extract.Price(Quandl("SCF/CME_SI1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Silver
CME_PL_price <- CME_PL_size * Extract.Price(Quandl("SCF/CME_PL1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Platinum
CME_PA_price <- CME_PA_size * Extract.Price(Quandl("SCF/CME_PA1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Palladium

#Base
SHFE_CU_price <- SHFE_CU_size * Extract.Price(Quandl("SCF/SHFE_CU1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Copper
SHFE_ZN_price <- SHFE_ZN_size * Extract.Price(Quandl("SCF/SHFE_ZN1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Copper

#Currencies
CME_AUD_price <- CME_AUD_size * Extract.Price(Quandl("SCF/CME_AD1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Ozzie
CME_CAD_price <- CME_CAD_size * Extract.Price(Quandl("SCF/CME_CD1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Loonie
CME_EUR_price <- CME_EUR_size * Extract.Price(Quandl("SCF/CME_EC1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Euro
CME_CHF_price <- CME_CHF_size * Extract.Price(Quandl("SCF/CME_SF1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Swiss Franc
ICE_GBP_price <- ICE_GBP_size * Extract.Price(Quandl("SCF/ICE_MP1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Cable
CME_JPY_price <- CME_JPY_size * Extract.Price(Quandl("SCF/CME_JY1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Yen
CME_NZD_price <- CME_NZD_size * Extract.Price(Quandl("SCF/CME_NE1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Kiwi
USD_price <- CME_CHF
USD[,2:dim(USD)[2]]=0

#Equities
CME_ES_EQ_price <- CME_ES_EQ_size * Extract.Price(Quandl("SCF/CME_SP1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Emini
CME_MD_EQ_price <- CME_MD_EQ_size * Extract.Price(Quandl("SCF/CME_MD1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Midcap 400
CME_NQ_EQ_price <- CME_NQ_EQ_size * Extract.Price(Quandl("SCF/CME_NQ1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Nasdaq 100
CME_NK_EQ_price <- CME_NK_EQ_size * Extract.Price(Quandl("SCF/CME_NK1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Nikkei
CME_DX_EQ_price <- CME_DX_EQ_size * Extract.Price(Quandl("SCF/EUREX_FDAX1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #DAX
#CME_SF_EQ_price <- _size * Extract.Price(Quandl("SCF/EUREX_FDAX1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #South Africa
CME_FTSE_EQ_price <- CME_FTSE_EQ_size * Extract.Price(Quandl("SCF/LIFFE_Z1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #FTSE

#Dollar Index and Bonds/Rates
#ICE_DX  <- quandClean("CHRIS/CME_DX", start_date=from, end_date=to, verbose=verbose) #Dixie
CME_FF_price <- CME_FF_size * Extract.Price(Quandl("SCF/CME_FF1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #30-day fed funds
CME_ED_price <- CME_ED_size * Extract.Price(Quandl("SCF/CME_ED1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #3 Mo. Eurodollar/TED Spread
CME_FV_price <- CME_FV_size * Extract.Price(Quandl("SCF/CME_FV1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Five Year TNote

CME_TY_price <- CME_TY_size * Extract.Price(Quandl("SCF/CME_TY1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #US Ten Year Note
#CME_CD_price <- _size * Extract.Price(Quandl("SCF/CME_CD1_ER", api_key="QwpBL4SFTYUEYH3qsWHs")) #Ten Year Note
CME_bund_price <- CME_bund_size * Extract.Price(Quandl("SCF/EUREX_FGBL1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Bund Ten Year Note
CME_GILT_price <- CME_GILT_size * Extract.Price(Quandl("SCF/LIFFE_R1_ON", api_key="QwpBL4SFTYUEYH3qsWHs")) #Gilt Ten Year Note

prices <- cbind(CME_wti_price, CME_NG_price, CME_HO_price, 
                CME_RB_price, ICE_Brent_price, ICE_Gasoil_price, 
                CME_C_price, CME_W_price, CME_KW_price, 
                CME_S_price, CME_SM_price, CME_BO_price, 
                ICE_SB_price, ICE_RobustaCoffee_price, ICE_CC_price, 
                ICE_CT_price, CME_LC_price, CME_LN_price, 
                CME_GC_price, CME_SI_price, CME_PL_price, 
                CME_PA_price, SHFE_CU_price, SHFE_ZN_price, 
                CME_AUD_price, CME_CAD_price, CME_EUR_price, 
                CME_CHF_price, ICE_GBP_price, CME_JPY_price, 
                CME_NZD_price, CME_ES_EQ_price, CME_MD_EQ_price, 
                CME_NQ_EQ_price, CME_NK_EQ_price, CME_DX_EQ_price, 
                CME_FTSE_EQ_price, CME_FF_price, CME_ED_price, 
                CME_FV_price, CME_TY_price, CME_bund_price, 
                CME_GILT_price)

assets <- c('CME_wti', 'CME_NG', 'CME_HO', 'CME_RB', 'ICE_Brent', 
  'ICE_Gasoil', 'CME_C', 'CME_W', 'CME_KW', 'CME_S', 'CME_SM', 
  'CME_BO', 'ICE_SB', 'ICE_RobustaCoffee', 'ICE_CC', 'ICE_CT', 
  'CME_LC', 'CME_LN', 'CME_GC', 'CME_SI', 'CME_PL', 'CME_PA', 
  'SHFE_CU', 'SHFE_ZN', 'AUD', 'CAD', 'EUR', 
  'CHF', 'GBP', 'JPY', 'NZD', 'CME_ES_EQ', 
  'CME_MD_EQ', 'CME_NQ_EQ', 'CME_NK_EQ', 'CME_DX_EQ', 
  'CME_FTSE_EQ', 'CME_FF', 'CME_ED', 'CME_FV', 'CME_TY', 
  'CME_bund', 'CME_GILT')

colnames(prices) = assets
