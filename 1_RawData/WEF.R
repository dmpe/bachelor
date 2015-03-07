library(stringr)
library(plyr)
library(xlsx)

wef <- read.xlsx("1_RawData/DataSources/GCR_Rankings_2014-2015.xlsx", sheetName = "GCI 2013-2014")[4:147, 1:3]
wef <- plyr::rename(wef, c("The.Global.Competitiveness.Index.2014.2015.rankings."="Country", "NA."="Ranking_WEF", "NA..1"  = "WEF_Score"))
wef$Country <- str_trim(wef$Country, side="both")

selectedCountries <- list('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")
# correct names and convert to numeric
# https://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-an-integer-numeric-without-a-loss-of-information
wef$Country[wef$Country=="Taiwan, China"] <-  "Taiwan"
wef$Country[wef$Country=="Korea, Rep."] <- "Korea"
wef$Country[wef$Country=="Russian Federation"] <- "Russia"

wef <- subset(wef, Country %in% selectedCountries)

# normalazing on the sample, not population
wef$WEF_Score_NonScaled <- as.numeric(levels(wef$WEF_Score)[wef$WEF_Score])
wef$WEF_Score <- as.numeric(scale(wef$WEF_Score_NonScaled))

# wef$WEF_Score <- as.numeric(scale(wef$WEF_Score_NonScaled))
# # sapply(wef, class)
# 
# 
# 
# wef$WEF_Score2 <- as.numeric(as.character(wef$WEF_Score))
# wef <- subset(wef, Country %in% selectedCountries, select=c(Country, Ranking_WEF, WEF_Score))
# wef$WEF_Score2 <- as.numeric(scale(wef$WEF_Score2))
