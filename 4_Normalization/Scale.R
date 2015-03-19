library(scales)
library(plyr)
library(Compind)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/MICE_Imputation.R")

#' http://howto.commetrics.com/methodology/statistics/normalization/
#' http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
#' http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
#' https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
#' https://stackoverflow.com/questions/5352099/how-to-disable-scientific-notation-in-r
#' https://stackoverflow.com/questions/7303322/apply-function-to-each-column-in-a-data-frame-observing-each-columns-existing-da
#' https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
#' that is the best
#' https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range 
#' https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value
#' 
#' This is non scaled data frame, containing same values in the joinedDB.6$LearningCurveIndex (only) 
#' From column country to row.names

nonScaledCompleteDF <- nonScaledDataFrame
nonScaledCompleteDF$LearningCurve_Index <- joinedDB.6$LearningCurve_Index
nonScaledCompleteDF <- data.frame(nonScaledCompleteDF[, -1], row.names = nonScaledCompleteDF[, 1])

#' For testing 
#' rescale(nonScaledDataFrame$Unemployment_NonScaled, to = c(0,3))
#' rescale(nonScaledDataFrame$Freedom_Index_NonScaled, to = c(0,3))
#' Now scale columns to 0 to 3. Don't apply to data frame !!!  
#' joinedDB.7 <- rescale(nonScaledCompleteDF, to = c(0,3)) # Wrong

rescaleColumns <- function(x, minValue, maxValue) {
  scales::rescale(x, to = c(minValue, maxValue))
}

#' newvalue = ((1-0)*(nonScaledCompleteDF$Unemployment_NonScaled-max(nonScaledCompleteDF$Unemployment_NonScaled))/
#'               (min(nonScaledCompleteDF$Unemployment_NonScaled)-max(nonScaledCompleteDF$Unemployment_NonScaled))) + 0
#' newvalueOpposite10 <- (max(nonScaledCompleteDF$Unemployment_NonScaled)-nonScaledCompleteDF$Unemployment_NonScaled)/
#' (max(nonScaledCompleteDF$Unemployment_NonScaled)-min(nonScaledCompleteDF$Unemployment_NonScaled))


#' Use colwise from plyr package to scale columns
#' Who created such a shit with function names ?
joinedDB.7 <- plyr::colwise(rescaleColumns)(nonScaledCompleteDF, 0, 100)
rownames(joinedDB.7) <- row.names(nonScaledCompleteDF)  

#' Unemployment_NonScaled goes into opposite direction, worst South Africa must be the worst, not best (e.i. that would be 
#' logic without this step below). 
joinedDB.7$Unemployment_NonScaled = ((100-0)*(nonScaledCompleteDF$Unemployment_NonScaled-max(nonScaledCompleteDF$Unemployment_NonScaled))/
                                       (min(nonScaledCompleteDF$Unemployment_NonScaled)-max(nonScaledCompleteDF$Unemployment_NonScaled))) + 0


# sapply(joinedDB.7, class)

#' Polarity vector: "POS" = positive, "NEG" = negative. The polarity of a individual indicator is the sign of the relationship between 
#' the indicator and the phenomenon to be measured (e.g., in a well-being index, 
#' "GDP per capita" has 'positive' polarity and "Unemployment rate" has 'negative' polarity).
#' 
#' see documentation with precise formulas
# normalise_ci(nonScaledCompleteDF,c(1:3),c("NEG","POS", "POS"), method=2)

# possible, used but not correct
# testJustSo <- max(nonScaledCompleteDF$Unemployment_NonScaled) + 
#  min(nonScaledCompleteDF$Unemployment_NonScaled) - nonScaledCompleteDF$Unemployment_NonScaled
# testJustSo


# To continue look in 'WeightingAggregation' folder, ->> 'WeAg.R' is required to run

 
