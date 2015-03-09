# This file loads necessary R-Scripts, adds additional data and finally creates data.frame

library(plyr)
library(dplyr)

# From R Documentation: source() causes R to accept its input from the named file or URL or connection.  Input is read and
# parsed from that file until the end of the file is reached, then the parsed expressions are evaluated sequentially in the
# chosen environment.
source("1_RawData/Unemplo.R")
source("1_RawData/FreedomIndex.R")
source("1_RawData/WEF.R")
source("1_RawData/LearningCurve.R")
source("1_RawData/CompletionRate.R")
source("1_RawData/HIndex.R")


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

 
