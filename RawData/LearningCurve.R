library(stringr)
library(plyr)
library(xlsx)


learningCurveData <- read.xlsx("RawData/DataSources/learningcurve.xlsx", sheetIndex = 1, 
                               startRow = 18, endRow = 58)

learningCurveData <- plyr::rename(learningCurveData, c("NA."="Country","Overall.Index" = "LearningCurveIndex"))
# sapply(learningCurveData, class) # factors -> to char

learningCurveData$Country <- as.character(learningCurveData$Country)

learningCurveData$Country[learningCurveData$Country=="South Korea"] <- "Korea"
learningCurveData$Country[learningCurveData$Country=="Hong Kong-China"] <- "China"

learningCurveData <- learningCurveData[, !(colnames(learningCurveData)
                  %in% c("Cognitive.Skills", "Educational.Attainment" ,"Notes","NA..1","NA..2"))]

learningCurveData$Ranking_LearningCurve <- seq(1,40) 









