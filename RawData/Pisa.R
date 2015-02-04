library(stringr)
library(plyr)
library(dplyr)
library(xlsx)

# https://stackoverflow.com/questions/4605206/drop-columns-r-data-frame

pisa <- read.csv("RawData/DataSources/PISAsummary-2012.csv", header=FALSE)

pisa <- plyr::rename(pisa, c("V1"="Ranking_PISA", "V2"="Country"))
pisa$Country <- str_trim(pisa$Country, side="both")
pisa$Country[pisa$Country=="Hong Kong-China"] <-"Hong Kong SAR"
pisa$Country[pisa$Country=="Shanghai-China"] <- "Shanghai"
pisa$Country[pisa$Country=="Taiwan Province of China"] <- "Taiwan"
pisa$Country[pisa$Country=="Russian Federation"] <- "Russia"


learningCurveData <- read.xlsx("RawData/DataSources/learningcurve.xlsx", 
                               sheetIndex = 1, startRow = 18, endRow = 58)

learningCurveData <- plyr::rename(learningCurveData, c("NA."="Country","Overall.Index" = "LearningCurveIndex"))
sapply(learningCurveData, class) # factors -> to char
learningCurveData$Country <- as.character(learningCurveData$Country)
learningCurveData$Country[learningCurveData$Country=="South Korea"] <- "Korea"
learningCurveData <- learningCurveData[, !(colnames(learningCurveData) %in% c("Cognitive.Skills", "Educational.Attainment" ,"Notes","NA..1","NA..2"))]

learningCurveData$LearningCurveRanking <- seq(1,40) 
# dew <- list('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")
# learningCurveData <- subset(learningCurveData, Country %in% dew )

# plot(lm(joinedDB.3$LearningCurveRanking ~ easydb$Ranking_EDB + wefGCI$Ranking_WEF))








