library(scales)
library(preprocessCore)

source("RawData/DataFrame.R")
source("Imputation/MICE_Imputation.R")



# normalize
normalized = (x-min(x))/(max(x)-min(x))

# https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range
# http://howto.commetrics.com/methodology/statistics/normalization/
# http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/
# http://chimera.labs.oreilly.com/books/1230000000345/ch07.html#_incorporating_scaled_values
# https://composite-indicators.jrc.ec.europa.eu/?q=content/overview
q = joinedDB.6$Freedom_Index


# MIN MAX
# 0 a 1
normalized = (q-min(q))/(max(q)-min(q))
normalized

#mezi -1 and 1
nor = (q - (max(q)+min(q) /2) ) / ((max(q)-min(q))/2)
nor

# Quantile normalization
normalize.quantiles(as.matrix(joinedDB.6))




