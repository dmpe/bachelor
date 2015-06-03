library(stringr)
library(plyr)
library(readxl)

learningCurveData <- read_excel("1_RawData/DataSources/learningcurve.xlsx", sheet = 1, skip = 6)[1:40,1:5]

learningCurveData <- plyr::rename(learningCurveData, c(NULL = "Country", Overall.Index = "LearningCurve_Index"))
# sapply(learningCurveData, class) # factors -> to char

learningCurveData$Country <- str_trim(learningCurveData$Country, side = "both")

learningCurveData$Country[learningCurveData$Country == "South Korea"] <- "Korea"
learningCurveData$Country[learningCurveData$Country == "Hong Kong-China"] <- "China"

#' delete some columns
learningCurveData <- learningCurveData[, !(colnames(learningCurveData) %in% c("Cognitive.Skills", "Educational.Attainment", 
    "Notes", "NA..1", "NA..2"))]

learningCurveData$Ranking_LearningCurve <- seq(1, 40)
# learningCurveData$LearningCurve_Index <- scale(learningCurveData$LearningCurve_Index)

#' mean of 24 countries z-score
#' format(round(mean(subset(learningCurveData, Country %in% selectedCountries)$LearningCurve_Index), 5), nsmall = 5) 






 
