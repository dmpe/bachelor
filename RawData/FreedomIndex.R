library(stringr)
library(plyr)
library(rvest)

fred <- html("http://www.heritage.org/index/explore")
freedom <- fred %>% 
  html_node("#ctl00_cphContent_ExpMulti_GridView1") %>%
  html_table()

freedom <- plyr::rename(freedom, c("overall score"="Freedom_Index", "name"="Country"))
freedom$Country <- str_trim(freedom$Country, side="both")
freedom$Country[freedom$Country=="South Korea"] <-  "Korea"
freedom$Freedom_Index <- suppressWarnings(as.numeric(freedom$Freedom_Index))

freedom <- subset(freedom, Country %in% selectedCountries, select=c(Country, Freedom_Index))

freedom$Freedom_Index_NonScaled <- freedom$Freedom_Index
freedom$Freedom_Index <- as.numeric(scale(freedom$Freedom_Index_NonScaled))

# sapply(freedom, class)

# library(xlsx)
# Excel Way
# freedom <- read.xlsx("RawData/DataSources/index2015_data.xlsx", sheetIndex = 1)
# freedom <- plyr::rename(freedom, c("Country.Name"="Country","X2015.Score" = "Freedom_Index"))
# freedom$Country <- str_trim(freedom$Country, side="both")
# freedom$Country[freedom$Country=="Korea, South"] <-  "Korea"
# freedom <- subset(freedom, Country %in% selectedCountries, select=c(Country, Freedom_Index))
# freedom$Freedom_Index <- as.numeric(as.character(freedom$Freedom_Index))
# #sapply(freedom, class)
