library(scales)
library(plyr)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")

#' ##########################################
#' http://howto.commetrics.com/methodology/statistics/normalization/
#' http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
#' http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
#' https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
#' https://stackoverflow.com/questions/5352099/how-to-disable-scientific-notation-in-r
#' https://stackoverflow.com/questions/7303322/apply-function-to-each-column-in-a-data-frame-observing-each-columns-existing-da
#' https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
#' https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range 
#' https://stackoverflow.com/questions/5294955/how-to-scale-down-a-range-of-numbers-with-a-known-min-and-max-value
#' library(Compind)
############################################

# rownames(df.Original.MinMax) <- row.names(df.Original.Imputed)  

#' create a new data frame (df.Original.MinMax) based on the old one (df.Original.Imputed). This 
#' makes 1:1 copy of the data frame, yet with the different name
df.Original.MinMax <- df.Original.Imputed

df.Original.MinMax$WEF_Score_NonScaled <- ((100-0)*(df.Original.Imputed$WEF_Score_NonScaled-1)/
                                             (7-1)) + 0

df.Original.MinMax$H_Index_NonScaled <- ((100-0)*(df.Original.Imputed$H_Index_NonScaled-1)/
                                           (1518-1)) + 0

# HDI's Educat. Index is between 0 and 1 -> convert to (by multipling it with) 0-100
df.Original.MinMax$HDIEducatIndex <- df.Original.Imputed$HDIEducatIndex * 100

#' Unemployment_NonScaled goes into opposite direction, worst South Africa must be the worst, not the best (e.i. that would be 
#' the logic without this step). 
df.Original.MinMax$Unemployment_NonScaled = ((100-0)*(df.Original.Imputed$Unemployment_NonScaled-100)/
                                               (0-100)) + 0


#' This normalizes columns of 'LearningCurve_Index' from minValue to maxValue. Beware of the colwise function that will be used on
#' on the whole data frame (from plyr)!
#' An assumption is made that although z-score beginngs from -Inf to Inf, I am going to use only a range between +-3.5
#' 
#' @param x A data frame
#' @param minValue A minimal value of the range of the scale (e.g. 0)
#' @param maxValue A maximal value of the range of the scale (e.g. 100)
rescaleColumns <- function(x, minValue, maxValue) {
  scales::rescale(x, to = c(minValue, maxValue), from = range(-3.5:3.5))
}

df.Original.MinMax$LearningCurve_Index <- plyr::colwise(rescaleColumns)(df.Original.Imputed, 0, 100)[, 4]



#' Polarity vector: "POS" = positive, "NEG" = negative. The polarity of a individual indicator is the sign of 
#' the relationship between the indicator and the phenomenon to be measured (e.g., in a well-being index, 
#' "GDP per capita" has 'positive' polarity and "Unemployment rate" has 'negative' polarity).
#' 
#' see documentation with precise formulas
#' normalise_ci(df.Original.Imputed,c(1:3),c("NEG","POS", "POS"), method=2)
