
library(stringr)
library(plyr)
# library(dplyr)
library(xlsx)
# https://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
# http://www.scimagojr.com/countryrank.php?area=0&category=0&region=all&year=all&order=h&min=0&min_type=it

hindex <- read.xlsx("RawData/DataSources/scimagojr.xlsx", sheetIndex = 1)
hindex  <- plyr::rename(hindex , c("H.index" = "HIndex"))
#sapply(hindex, class) # factors -> to char
hindex$Country <- str_trim(hindex$Country, side="both")
hindex$Country[hindex$Country=="South Korea"] <-  "Korea"
hindex$Country[hindex$Country=="Russian Federation"] <- "Russia"

hindex <- hindex[, !(colnames(hindex) %in% c("Documents", "Citable.documents" ,"Citations","Self.Citations","Citations.per.Document"))]

hindex = subset(hindex, 
                Country %in% c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand"))

# not used hindex <- plyr::arrange(hindex,desc(HIndex))

