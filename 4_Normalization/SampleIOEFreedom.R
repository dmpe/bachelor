library(scales)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
 
# Scale IEF's original value for 23 countries
ief <- nonScaledDataFrame  # this has always 23 obs. 
ief$MinMax23Sample <- rescale(nonScaledDataFrame$Freedom_Index_NonScaled, to = c(0, 1))
ief <- head(ief[, c("Country", "Freedom_Index_NonScaled", "MinMax23Sample")])

# Scale IEF's original values for the whole population
freedom_population <- freedom_normalisation  # always 178 obs.
freedom_population$MinMaxOverall <- rescale(freedom_normalisation$Freedom_Index, to = c(0, 1))  # Min-Max
freedom_population$ZScoreOverall <- scale(freedom_normalisation$Freedom_Index)  # Z-Score
freedom_population <- freedom_population[, c("Country", "MinMaxOverall", "RankOverall", "ZScoreOverall")]
# take only 6 countries from the above
freedom_population <- subset(freedom_population, Country %in% c("Australia", "Brazil", "Canada", "China", "Chile", "Czech Republic"))

# Combine freedom_population and ief into one dataset, by Country
freedom_combined <- dplyr::full_join(ief, freedom_population, by = "Country")
freedom_combined <- freedom_combined[, c(1, 5, 2, 3, 4, 6)]

# Take additionally 5 countries from the 23 sample
freedom_combined$ZScore23Sample <- subset(df.Zscore, Country %in% c("Australia", "Brazil", "Canada", "China", "Chile", "Czech Republic"))$Freedom_Index

freedom_combined <- plyr::arrange(freedom_combined, desc(freedom_combined$Freedom_Index_NonScaled))
freedom_combined <- freedom_combined[, c(1, 2, 3, 4, 5, 7, 6)]
freedom_combined <- round(freedom_combined[, -1], 4)


 
