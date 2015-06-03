library(plyr)
library(dplyr)
set.seed(5154)

###########################
# From R Documentation: source() causes R to accept its input from the named file or URL or connection.  Input is read and
# parsed from that file until the end of the file is reached, then the parsed expressions are evaluated sequentially in the
# chosen environment.
# source("1_RawData/CompletionRate.R")
# This file loads necessary R-Scripts, adds additional data and finally creates data.frame
###########################

source("1_RawData/EUI.R")
source("1_RawData/LearningCurve.R")
source("1_RawData/Unemplo.R")
source("1_RawData/FreedomIndex.R")
source("1_RawData/WEF.R")
source("1_RawData/HIndex.R")

# Data here are non scaled, they contain 'the real values'.

df.Original <- dplyr::left_join(unemplo, freedom, by = "Country")

df.Original <- dplyr::left_join(df.Original, wef, by = "Country")
df.Original <- plyr::arrange(df.Original, df.Original$Country)

df.Original <- dplyr::left_join(df.Original, learningCurveData, by = "Country")
df.Original <- plyr::arrange(df.Original, df.Original$Country)
df.Original <- subset(df.Original, select = c(Country, Unemployment_NonScaled, 
                                              Freedom_Index_NonScaled, WEF_Score_NonScaled, LearningCurve_Index))

df.Original <- dplyr::left_join(df.Original, hindex, by = "Country")
df.Original <- plyr::arrange(df.Original, df.Original$Country)

df.Original <- dplyr::left_join(df.Original, hdi, by = "Country")
df.Original <- plyr::arrange(df.Original, df.Original$Country)
df.Original <- subset(df.Original, select = c(Country, Unemployment_NonScaled, Freedom_Index_NonScaled, WEF_Score_NonScaled, 
                                              LearningCurve_Index, HDIEducatIndex, H_Index_NonScaled))

# http://stackoverflow.com/a/10331131
sapply(df.Original, class)

