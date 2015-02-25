# normalize
normalized = (x-min(x))/(max(x)-min(x))

# https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range
# http://howto.commetrics.com/methodology/statistics/normalization/
# http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
# http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
# https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
q = df$ExpenditurePerStudentInGDP


# MIN MAX
# 0 a 1
normalized = (q-min(q))/(max(q)-min(q))
normalized

#mezi -1 and 1
nor = (q - (max(q)+min(q) /2) ) / ((max(q)-min(q))/2)
nor

# Quantile normalization
normalize.quantiles(as.matrix(df[2:8]))

source("RawData/DataFrame.R")
source("Imputation/MICE_Imputation.R")


scaledOnlyThoseNeeded <- scale(joinedDB.6[, c("Unemployment", "Freedom_Index", "WEF_Score", "CompletionRate", "Ranking_HIndex")])

