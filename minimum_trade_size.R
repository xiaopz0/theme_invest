
#Energies
CME_wti_size <- 1000 #Crude, dollar per barrel for 1000 barrels
CME_NG_size <- 10000 #NatGas, dollar per mmBtu for 10,000 mmBtu
CME_HO_size <- 42000 #HeatingOil, dollar per gallon for 42,000 gallons
CME_RB_size <- 42000 #Gasoline, dollar per gallon for 42,000 gallons
ICE_Brent_size <- 1000 #Brent, dollar per barrel for 1000 barrels
ICE_Gasoil_size <- 0.25*100 #Gasoil, 25 cents for tonne for 100 metric tons

#Grains
CME_C_size <- 1/100*5000  #Chicago Corn, cents per bushel for 5000 bushel
CME_W_size <- 1/100*5000  #Chicago Wheat, cents per bushel for 5000 bushel
CME_KW_size <- 1/100*5000  #Kansas City Wheat, cents per bushel for 5000 bushel
CME_S_size <- 1/100*5000  #Chicago Soybeans, cents per bushel for 5000 bushel
CME_SM_size <- 1/10*100 #Chicago Soybean Meal, 10 cents per short ton for 100 short tons
CME_BO_size <- 1/100*60000 #Chicago Soybean Oil, cents per pound for 60000 bushel

#Softs
ICE_SB_size <- 1/100/100*112000 #Sugar, 1/100 cents per lb for 112000 lbs
ICE_RobustaCoffee_size <- 5/100*37500 #Coffee, 5/100 cents per lb for 37500 lbs
ICE_CC_size <- 10 #Cocoa, dollar per metric ton for 10 metric tons
ICE_CT_size <- 1/100/100*50000 #Cocoa, 1/100 cents per lb for 50,000 lbs

#Other Ags
CME_LC_size <- 1/100*40000 #Live Cattle, 1/100 cents per lb for 40,000 lbs
CME_LN_size <- 1/100*40000 #Lean Hogs, 1/100 cents per lb for 40,000 lbs

#Precious Metals
CME_GC_size <- 100 #Gold, dollar per troy ounce for 100 troy ounce
CME_SI_size <- 5000 #Silver, dollar per troy ounce for 5000 troy ounce
CME_PL_size <- 50 #Platinum, dollar per troy ounce for 50 troy ounce 
CME_PA_size <- 100 #Palladium, dollar per troy ounce for 100 troy ounce 

#Base
SHFE_CU_size <- 10*0.15*5 #Copper, 10 yuan per ton for 5 tons
SHFE_ZN_size <- 10*0.15*5 #Zinc, 10 yuan per ton for 5 tons

#Currencies
CME_AUD_size <- 100000  #Ozzie
CME_CAD_size <- 100000  #Loonie
CME_EUR_size <- 125000 #Euro
CME_CHF_size <- 125000 #Swiss Franc
ICE_GBP_size <- 62500 #Cable
CME_JPY_size <- 1/10 #Yen, not sure
CME_NZD_size <- 100000 #Kiwi
USD_size <- CME_CHF
USD[,2:dim(USD)[2]]=0

#Equities
CME_ES_EQ_size <- 50 #Emini
CME_MD_EQ_size <- 100 #Midcap 400
CME_NQ_EQ_size <- 20 #Nasdaq 100
CME_NK_EQ_size <- 5 #Nikkei
CME_DX_EQ_size <- 25*1.12  #DAX
#CME_SF_EQ_size <- Quandl("SCF/EUREX_FDAX1_OR", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #South Africa
CME_FTSE_EQ_size <- 10 #FTSE

#Dollar Index and Bonds/Rates
#ICE_DX_size <- quandClean("CHRIS/CME_DX", start_date=from, end_date=to, verbose=verbose) #Dixie
CME_FF_size <- -1/100*5000000/12 #30-day fed funds, (1 - quote/100) interest on Fed Funds having a face value of $5,000,000 for one month.
CME_ED_size <- -1/100*1000000/4 #3 Mo. Eurodollar/TED Spread
CME_FV_size <- 1000  #Five Year TNote, not sure

CME_TY_size <- 1000 #US Ten Year Note
#CME_CD_size <- Quandl("SCF/CME_CD1_ER", api_key="QwpBL4SFTYUEYH3qsWHs", transform="rdiff") #Ten Year Note
CME_bund_size <- 1000 #Bund Ten Year Note
CME_GILT_size <- 1000 #Gilt Ten Year Note

