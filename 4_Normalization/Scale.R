library(scales)
library(plyr)

# source("1_RawData/DataFrame.R")
# source("2_Imputation/MICE_Imputation.R")

# https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range that is the best
# https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value
# http://howto.commetrics.com/methodology/statistics/normalization/
# http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
# http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
# https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
# https://stackoverflow.com/questions/5352099/how-to-disable-scientific-notation-in-r
# https://stackoverflow.com/questions/7303322/apply-function-to-each-column-in-a-data-frame-observing-each-columns-existing-da
# https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r

#' MIN MAX mezi 0 a 1 
#' normalized = (q-min(q))/(max(q)-min(q)) 
#' normalized 
#' mezi -1 and 1 
#' nor = (q - (max(q)+min(q) /2) ) /((max(q)-min(q))/2) 
#' nor


#' This is non scaled data frame, containing same values in the joinedDB.6$LearningCurveIndex (only) 
#'From column country to row.names

nonScaledCompleteDF <- nonScaledDataFrame
nonScaledCompleteDF$LearningCurve_Index <- joinedDB.6$LearningCurve_Index
nonScaledCompleteDF <- data.frame(nonScaledCompleteDF[, -1], row.names = nonScaledCompleteDF[, 1])

#' For testing 
#' rescale(nonScaledDataFrame$Unemployment_NonScaled, to = c(0,3))
#' rescale(nonScaledDataFrame$Freedom_Index_NonScaled, to = c(0,3))

#' Now scale columns to 0 to 3. Don't apply to data frame !!!  
#' joinedDB.7 <- rescale(nonScaledCompleteDF, to = c(0,3)) # Wrong

rescaleColumns <- function(x) {
    rescale(x, to = c(0, 3))
}

# Use colwise from plyr package
joinedDB.7 <- colwise(rescaleColumns)(nonScaledCompleteDF)
rownames(joinedDB.7) <- row.names(nonScaledCompleteDF)  # who created such a shit with function names ?

sapply(joinedDB.7, class)

# To continue look in 'WeightingAggregation' folder, ->> 'WeAg.R' is required to run





 
