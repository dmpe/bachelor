library(stringr)
library(plyr)
library(xlsx)

# https://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
# http://www.scimagojr.com/countryrank.php?area=0&category=0&region=all&year=all&order=h&min=0&min_type=it > Download

hindex <- read.xlsx("1_RawData/DataSources/scimagojr.xlsx", sheetIndex = 1)

# sapply(hindex, class) # factors -> to char

hindex$Country <- str_trim(hindex$Country, side = "both")
hindex$Country[hindex$Country == "South Korea"] <- "Korea"
hindex$Country[hindex$Country == "Russian Federation"] <- "Russia"

hindex <- hindex[, !(colnames(hindex) %in% c("Documents", "Citable.documents", "Citations", "Self.Citations", "Citations.per.Document"))]
hindex <- plyr::rename(hindex, c(H.index = "H_Index"))

hindex <- subset(hindex, Country %in% selectedCountries, select = c(Country, Rank, H_Index))

hindex$H_Index_NonScaled <- hindex$H_Index
hindex$H_Index <- as.numeric(scale(hindex$H_Index_NonScaled))

sapply(hindex, class) 
