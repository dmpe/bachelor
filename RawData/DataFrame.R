# This file loads necessary R-Scripts, adds additional data and finally creates data.frame

library(plyr); 
library(dplyr)

# From R Documentation:
# source() causes R to accept its input from the named file or URL or connection.
# Input is read and parsed from that file until the end of the file is reached, then the 
# parsed expressions are evaluated sequentially in the chosen environment. 
source("RawData/Unemplo.R")
source("RawData/FreedomIndex.R")
source("RawData/WEF.R")
source("RawData/LearningCurve.R")
source("RawData/CompletionRate.R")
source("RawData/HIndex.R")


joinedDF <- dplyr::left_join(df_unemp, freedom, by = "Country")

joinedDB.2 <- dplyr::left_join(joinedDF, wef, by = "Country")
joinedDB.2 <- plyr::arrange(joinedDB.2,joinedDB.2$Country)

joinedDB.3 <- dplyr::left_join(joinedDB.2, learningCurveData, by = "Country")
joinedDB.3 <- plyr::arrange(joinedDB.3,joinedDB.3$Country)
joinedDB.3 <- subset(joinedDB.3, select=c(Country, Unemployment, Freedom_Index, WEF_Score, LearningCurve_Index))

joinedDB.4 <- dplyr::left_join(joinedDB.3, CompletionRate, by = "Country")
joinedDB.4 <- plyr::arrange(joinedDB.4,joinedDB.4$Country)

joinedDB.5 <- dplyr::left_join(joinedDB.4, hindex, by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5,joinedDB.5$Country)
joinedDB.5 <- subset(joinedDB.5, select=c(Country, Unemployment, Freedom_Index,
                                          WEF_Score, LearningCurve_Index, CompletionRate, Ranking_HIndex))


# To continue look in 'Imputation' folder, ->> 'MICE_Imputation.R'


# http://stackoverflow.com/a/10331131
sapply(joinedDB.5, class)


