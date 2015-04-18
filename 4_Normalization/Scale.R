library(scales)
library(plyr)
library(Compind)

set.seed(5154)


#' ##########################################
#' This is only                             #
#' for Min MAX but now also for ZSCORE too  #
#' http://howto.commetrics.com/methodology/statistics/normalization/
#' http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
#' http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
#' https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
#' https://stackoverflow.com/questions/5352099/how-to-disable-scientific-notation-in-r
#' https://stackoverflow.com/questions/7303322/apply-function-to-each-column-in-a-data-frame-observing-each-columns-existing-da
#' https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
#' https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range 
#' https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value

############################################

# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")


#' For testing 
#' rescale(nonScaledDataFrame$Unemployment_NonScaled, to = c(0,3))
#' rescale(nonScaledDataFrame$Freedom_Index_NonScaled, to = c(0,3))
#' Now scale columns to 0 to 3. Don't apply to data frame !!!  
#' joinedDB.7 <- rescale(df.Original.Imputed, to = c(0,3)) # Wrong
#' 
#' newvalue = ((1-0)*(df.Original.Imputed$Unemployment_NonScaled-max(df.Original.Imputed$Unemployment_NonScaled))/
#'               (min(df.Original.Imputed$Unemployment_NonScaled)-max(df.Original.Imputed$Unemployment_NonScaled))) + 0
#' newvalueOpposite10 <- (max(df.Original.Imputed$Unemployment_NonScaled)-df.Original.Imputed$Unemployment_NonScaled)/
#' (max(df.Original.Imputed$Unemployment_NonScaled)-min(df.Original.Imputed$Unemployment_NonScaled))

rescaleColumns <- function(x, minValue, maxValue) {
  scales::rescale(x, to = c(minValue, maxValue))
}


#' Use colwise from plyr package to scale columns
df.Original.MinMax <- plyr::colwise(rescaleColumns)(df.Original.Imputed, 0, 100)
rownames(df.Original.MinMax) <- row.names(df.Original.Imputed)  

#' Unemployment_NonScaled goes into opposite direction, worst South Africa must be the worst, not best (e.i. that would be 
#' the logic without this step below). 
df.Original.MinMax$Unemployment_NonScaled = ((100-0)*(df.Original.Imputed$Unemployment_NonScaled-max(df.Original.Imputed$Unemployment_NonScaled))/
                                       (min(df.Original.Imputed$Unemployment_NonScaled)-max(df.Original.Imputed$Unemployment_NonScaled))) + 0
# VELKY PRUSER ? CO STIM TED
# df.Original.MinMax$Freedom_Index_NonScaled <- df.Original$Freedom_Index_NonScaled

# copy and create new data set with new polarity of unempl.
df.Zscore.Imputed$Unemployment <- unemplo$Unemployment_ZscoreNEGATIVE

#' Polarity vector: "POS" = positive, "NEG" = negative. The polarity of a individual indicator is the sign of the relationship between 
#' the indicator and the phenomenon to be measured (e.g., in a well-being index, 
#' "GDP per capita" has 'positive' polarity and "Unemployment rate" has 'negative' polarity).
#' 
#' see documentation with precise formulas
# normalise_ci(df.Original.Imputed,c(1:3),c("NEG","POS", "POS"), method=2)




############# To continue, look in 'WeightingAggregation' folder, ->> 'WeAg.R' is required to run

 
