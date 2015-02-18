
library(stringr)
library(plyr)
library(xlsx)

# https://stackoverflow.com/questions/1296646/how-to-sort-a-dataframe-by-columns-in-r
# http://www.scimagojr.com/countryrank.php?area=0&category=0&region=all&year=all&order=h&min=0&min_type=it > Download

freedom <- read.xlsx("RawData/DataSources/index2014_data.xls", sheetIndex = 1)

freedom <- plyr::rename(freedom, c("Country.Name"="Country","X2014.Score" = "Freedom_Index"))
# sapply(freedom, class) # factors -> to char

freedom$Country <- str_trim(freedom$Country, side="both")
freedom$Country[freedom$Country=="Korea, South"] <-  "Korea"
freedom <- subset(freedom, Country %in% selectedCountries, select=c(Country, Freedom_Index))

freedom$Freedom_Index <- as.numeric(as.character(freedom$Freedom_Index))
sapply(freedom, class)
