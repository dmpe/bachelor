library(stringr)
library(plyr)
library(xlsx)

learningCurveData <- read.xlsx("1_RawData/DataSources/learningcurve.xlsx", sheetIndex = 1, startRow = 18, endRow = 58)

learningCurveData <- plyr::rename(learningCurveData, c(NA. = "Country", Overall.Index = "LearningCurve_Index"))
# sapply(learningCurveData, class) # factors -> to char

learningCurveData$Country <- str_trim(learningCurveData$Country, side = "both")

learningCurveData$Country[learningCurveData$Country == "South Korea"] <- "Korea"
learningCurveData$Country[learningCurveData$Country == "Hong Kong-China"] <- "China"

learningCurveData <- learningCurveData[, !(colnames(learningCurveData) %in% c("Cognitive.Skills", "Educational.Attainment", 
    "Notes", "NA..1", "NA..2"))]

learningCurveData$Ranking_LearningCurve <- seq(1, 40)
# learningCurveData$LearningCurve_Index <- scale(learningCurveData$LearningCurve_Index)

#' mean of 18 countries z-score
#' testingEDuOu <- subset(learningCurveData, Country %in% selectedCountries)
#' mean(testingEDuOu$LearningCurve_Index)






 
