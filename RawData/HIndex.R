
library(stringr)
library(plyr)
library(xlsx)

# https://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
# http://www.scimagojr.com/countryrank.php?area=0&category=0&region=all&year=all&order=h&min=0&min_type=it > Download

hindex_orig <- read.xlsx("RawData/DataSources/scimagojr.xlsx", sheetIndex = 1)

#sapply(hindex, class) # factors -> to char

hindex_orig$Country <- str_trim(hindex_orig$Country, side="both")
hindex_orig$Country[hindex_orig$Country=="South Korea"] <-  "Korea"
hindex_orig$Country[hindex_orig$Country=="Russian Federation"] <- "Russia"

hindex_orig <- hindex_orig[, !(colnames(hindex_orig) %in% c("Documents", "Citable.documents" ,"Citations","Self.Citations","Citations.per.Document"))]

hindex <- subset(hindex_orig, Country %in% c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand"),
                 select = c(Country, Rank, H.index))

hindex  <- plyr::rename(hindex , c("Rank" = "Ranking_HIndex"))
# not used hindex <- plyr::arrange(hindex,desc(HIndex))
# "H.index" = "HIndex",
