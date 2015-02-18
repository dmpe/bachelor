# normalize
normalized = (x-min(x))/(max(x)-min(x))

# https://stats.stackexchange.com/questions/70801/how-to-normalize-data-to-0-1-range
# http://howto.commetrics.com/methodology/statistics/normalization/
# http://www.benetzkorn.com/2011/11/data-normalization-and-standardization/

q = df$ExpenditurePerStudentInGDP

# Z SCORE

te =scale(df$ExpenditurePerStudentInGDP)
te

# by mela byt stejna -> je
de = (q-mean(q))/sd(q)
de

# MIN MAX
# 0 a 1
normalized = (q-min(q))/(max(q)-min(q))
normalized

#mezi -1 and 1
nor = (q - (max(q)+min(q) /2) ) / ((max(q)-min(q))/2)
nor

# Quantile normalization
normalize.quantiles(as.matrix(df[2:8]))
