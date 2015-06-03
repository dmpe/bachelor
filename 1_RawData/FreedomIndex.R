library(stringr)
library(plyr)
library(readxl)

# Excel Way
freedom <- read_excel("1_RawData/DataSources/index2015_data.xlsx", sheet = 1)
freedom <- plyr::rename(freedom, c("Country Name" = "Country", "2015 Score" = "Freedom_Index", "World Rank" = "RankOverall"), warn_duplicated = F)
freedom$Country <- str_trim(freedom$Country, side = "both")
freedom$Country[freedom$Country == "Korea, South"] <- "Korea"
freedom <- subset(freedom, select = c(Country, Freedom_Index, RankOverall))

# convert from factor to numeric
freedom$Freedom_Index <- suppressWarnings(as.numeric(as.character(freedom$Freedom_Index)))
freedom$RankOverall <- suppressWarnings(as.numeric(as.character(freedom$RankOverall)))

freedom_normalisation <- na.omit(freedom)

freedom <- subset(freedom, Country %in% selectedCountries, select = c(Country, Freedom_Index, RankOverall))

freedom$Freedom_Index_NonScaled <- freedom$Freedom_Index
freedom$Freedom_Index <- as.numeric(scale(freedom$Freedom_Index_NonScaled))

sapply(freedom, class) 
