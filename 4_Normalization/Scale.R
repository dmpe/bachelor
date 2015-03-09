library(scales)
library(preprocessCore)

source("1_RawData/DataFrame.R")
source("2_Imputation/MICE_Imputation.R")



# normalize
normalized = (x-min(x))/(max(x)-min(x))

# https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range
# https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value
# that is the best
# http://howto.commetrics.com/methodology/statistics/normalization/
# http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
# http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
# https://composite-indicators.jrc.ec.europa.eu/?q=content/overview

# # MIN MAX
# # 0 a 1
# normalized = (q-min(q))/(max(q)-min(q))
# normalized
# 
# #mezi -1 and 1
# nor = (q - (max(q)+min(q) /2) ) / ((max(q)-min(q))/2)
# nor


# This is non scaled data frame, containing same values in the joinedDB.6$LearningCurveIndex (only)
# From column country to row.names
# https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r

nonScaledDataFrame.complete.test <- nonScaledDataFrame
nonScaledDataFrame.complete.test$LearningCurve_Index <- joinedDB.6$LearningCurve_Index 
nonScaledDataFrame.complete.test <- data.frame(nonScaledDataFrame.complete.test[,-1], 
                                               row.names=nonScaledDataFrame.complete.test[,1])
# Now scale them to 0 to 3
joinedDB.7 <- rescale(nonScaledDataFrame.complete.test, to = c(0,3))

# joinedDB.7 <- joinedDB.7[, c(7,1,2,3,4,5,6)] # Reorder them

# nonScaledDataFrame.complete.minmaxscaled <- rescale(as.factor(input.mi.df))

sapply(joinedDB.7, class)



















