# This file loads necessary R-Scripts, adds additional data and finally creates data.frame

# From R Documentation:
# source() causes R to accept its input from the named file or URL or connection.
# Input is read and parsed from that file until the end of the file is reached, then the 
# parsed expressions are evaluated sequentially in the chosen environment. 
source("RawData/DF_ImprovedGDP.R")
source("RawData/Pisa.R")
source("RawData/WEF.R")
source("RawData/EasyOfDoingBusiness.R")
source("RawData/TSR.R")
source("RawData/Expend.R")
source("RawData/Unemplo.R")
# For their sources see my thesis, and corresponding table

joinedDF <- dplyr::left_join(TigersGDP, pisa, by= "Country")
joinedDF <- subset(joinedDF, select=c(Country, GDPinDollars, Ranking_PISA))

joinedDB.3 <- dplyr::left_join(joinedDF, easydb, by= "Country")
joinedDB.3$Country <- str_trim(joinedDB.3$Country, side="both")
joinedDB.3 <- subset(joinedDB.3, select=c(Country, GDPinDollars, Ranking_EDB, Ranking_PISA))
joinedDB.3 <- plyr::arrange(joinedDB.3,joinedDB.3$Country)

# wef+gdp+pisa+edb
joinedDB.6 <- dplyr::left_join(joinedDB.3, wefGCI, by = "Country")
joinedDB.6 <- plyr::arrange(joinedDB.6,joinedDB.6$Country)

joinedDB.7 <- dplyr::left_join(joinedDB.6, df_education, by = "Country")
joinedDB.7 <- plyr::arrange(joinedDB.7,joinedDB.7$Country)

joinedDB.8 <- dplyr::left_join(joinedDB.7, df_expenditures, by = "Country")
joinedDB.8 <- plyr::arrange(joinedDB.8,joinedDB.8$Country)

joinedDB.9 <- dplyr::left_join(joinedDB.8, df_unemp, by = "Country")
joinedDB.9 <- plyr::arrange(joinedDB.9,joinedDB.9$Country)


# wide format
#df = data.frame(TigersGDP, EasyBusiness, Pisa, PupilPerTeachersRatio, AvarageClassSize, ExpenditurePerStudent, PMIData)
# 
# rownames(df) = 1:nrow(df)
# df

# Check that all var. in df are numeric
# http://stackoverflow.com/a/10661161
lapply(joinedDB.9, class)


