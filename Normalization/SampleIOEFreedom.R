library(scales)

set.seed(5154)
source("RawData/DataFrame_NonScaled.R")


headDf <- head(nonScaledDataFrame)
headDf <- headDf[, c("Country", "Freedom_Index_NonScaled")]


headDf$MinMax <- rescale(headDf$Freedom_Index_NonScaled, to = c(0,1))









