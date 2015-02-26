library(scales)

set.seed(5154)
source("RawData/DataFrame.R")
source("RawData/DataFrame_NonScaled.R")

headDf <- nonScaledDataFrame
headDf$MinMax23Sample <- rescale(nonScaledDataFrame$Freedom_Index_NonScaled, to = c(0,1))
headDf <- head(headDf[, c("Country", "Freedom_Index_NonScaled", "MinMax23Sample")])


freedom_normalisation.test <- freedom_normalisation
freedom_normalisation.test$MinMaxOverall <- rescale(freedom_normalisation$Freedom_Index, to = c(0,1))
freedom_normalisation.test <- freedom_normalisation.test[, c("Country", "MinMaxOverall", "RankOverall")]

freedom_normalisation.test <- subset(freedom_normalisation.test, Country %in% c("Australia", "Brazil", "Canada", "China", "Chile", "Czech Republic"))

freedom.example <- dplyr::full_join(headDf, freedom_normalisation.test, by = "Country")
freedom.example <- freedom.example[,c(1,5,2,3,4)]
freedom.example <- plyr::arrange(freedom.example, desc(freedom.example$Freedom_Index_NonScaled))
