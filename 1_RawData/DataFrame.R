# This file loads necessary R-Scripts, adds additional data and finally creates data.frame

library("plyr")
library("dplyr")
set.seed(5154)
# From R Documentation: source() causes R to accept its input from the named file or URL or connection.  Input is read and
# parsed from that file until the end of the file is reached, then the parsed expressions are evaluated sequentially in the
# chosen environment.
source("1_RawData/Unemplo.R")
source("1_RawData/FreedomIndex.R")
source("1_RawData/WEF.R")
source("1_RawData/LearningCurve.R")
source("1_RawData/CompletionRate.R")
source("1_RawData/HIndex.R")


joinedDB.5 <- dplyr::left_join(df_unemp, freedom, by = "Country")

joinedDB.5 <- dplyr::left_join(joinedDB.5, wef, by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5, joinedDB.5$Country)

joinedDB.5 <- dplyr::left_join(joinedDB.5, learningCurveData, by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5, joinedDB.5$Country)
joinedDB.5 <- subset(joinedDB.5, select = c(Country, Unemployment, Freedom_Index, WEF_Score, LearningCurve_Index))

joinedDB.5 <- dplyr::left_join(joinedDB.5, CompletionRate, by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5, joinedDB.5$Country)

joinedDB.5 <- dplyr::left_join(joinedDB.5, hindex, by = "Country")
joinedDB.5 <- plyr::arrange(joinedDB.5, joinedDB.5$Country)
joinedDB.5 <- subset(joinedDB.5, select = c(Country, Unemployment, Freedom_Index, WEF_Score, LearningCurve_Index, CompletionRate, 
    Ranking_HIndex))


# http://stackoverflow.com/a/10331131
sapply(joinedDB.5, class)




# Data here are non scaled, they contain 'the real values'.

nonScaledDataFrame <- dplyr::left_join(df_unemp, freedom, by = "Country")

nonScaledDataFrame <- dplyr::left_join(nonScaledDataFrame, wef, by = "Country")
nonScaledDataFrame <- plyr::arrange(nonScaledDataFrame, nonScaledDataFrame$Country)

nonScaledDataFrame <- dplyr::left_join(nonScaledDataFrame, learningCurveData, by = "Country")
nonScaledDataFrame <- plyr::arrange(nonScaledDataFrame, nonScaledDataFrame$Country)
nonScaledDataFrame <- subset(nonScaledDataFrame, select = c(Country, Unemployment_NonScaled, Freedom_Index_NonScaled, WEF_Score_NonScaled, 
    LearningCurve_Index))

nonScaledDataFrame <- dplyr::left_join(nonScaledDataFrame, CompletionRate, by = "Country")
nonScaledDataFrame <- plyr::arrange(nonScaledDataFrame, nonScaledDataFrame$Country)

nonScaledDataFrame <- dplyr::left_join(nonScaledDataFrame, hindex, by = "Country")
nonScaledDataFrame <- plyr::arrange(nonScaledDataFrame, nonScaledDataFrame$Country)
nonScaledDataFrame <- subset(nonScaledDataFrame, select = c(Country, Unemployment_NonScaled, Freedom_Index_NonScaled, WEF_Score_NonScaled, 
    LearningCurve_Index, CompletionRate_NonScaled, Ranking_HIndex_NonScaled))


# To continue look in 'Imputation' folder, ->> 'MICE_Imputation.R'


# http://stackoverflow.com/a/10331131
sapply(nonScaledDataFrame, class)
 
