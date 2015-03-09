
# https://stackoverflow.com/questions/4605206/drop-columns-r-data-frame pisa <-
# read.csv('RawData/DataSources/PISAsummary-2012.csv', header=FALSE) pisa <- plyr::rename(pisa, c('V1'='Ranking_PISA',
# 'V2'='Country')) pisa$Country <- str_trim(pisa$Country, side='both') pisa$Country[pisa$Country=='Hong Kong-China']
# <-'Hong Kong SAR' pisa$Country[pisa$Country=='Shanghai-China'] <- 'Shanghai' pisa$Country[pisa$Country=='Taiwan Province
# of China'] <- 'Taiwan' pisa$Country[pisa$Country=='Russian Federation'] <- 'Russia' 
