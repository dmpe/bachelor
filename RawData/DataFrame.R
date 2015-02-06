# This file loads necessary R-Scripts, adds additional data and finally creates data.frame

# From R Documentation:
# source() causes R to accept its input from the named file or URL or connection.
# Input is read and parsed from that file until the end of the file is reached, then the 
# parsed expressions are evaluated sequentially in the chosen environment. 
source("RawData/Unemplo.R")
source("RawData/EasyOfDoingBusiness.R")
source("RawData/WEF.R")
source("RawData/LearningCurve.R")
source("RawData/CompletionRate.R")
# source("RawData/Expend.R")

# For their sources see my thesis, and corresponding table

joinedDF <- dplyr::left_join(df_unemp, easydb, by= "Country")
# GDPinDollars
joinedDB.2 <- dplyr::left_join(joinedDF, wefGCI, by= "Country")
joinedDB.2 <- plyr::arrange(joinedDB.2,joinedDB.2$Country)

# wef+gdp+pisa+edb
joinedDB.3 <- dplyr::left_join(joinedDB.2, learningCurveData, by = "Country")
joinedDB.3 <- plyr::arrange(joinedDB.3,joinedDB.3$Country)
joinedDB.3 <- subset(joinedDB.3, select=c(Country, Unemployment, Ranking_EDB, Ranking_WEF, LearningCurveRanking))

joinedDB.4 <- dplyr::left_join(joinedDB.3, CompletionRate, by = "Country")
joinedDB.4 <- plyr::arrange(joinedDB.4,joinedDB.4$Country)

joinedDB.5 <- dplyr::left_join(joinedDB.4, , by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5,joinedDB.5$Country)


# wide format
#df = data.frame(TigersGDP, EasyBusiness, Pisa, PupilPerTeachersRatio, AvarageClassSize, ExpenditurePerStudent, PMIData)
# 
# rownames(df) = 1:nrow(df)
# df

# Check that all var. in df are numeric
# http://stackoverflow.com/a/10331131
lapply(joinedDB.9, class)


