library(stringr)
library(plyr)
library(xlsx)

wef <- read.xlsx("RawData/DataSources/GCR_Rankings_2014-2015.xlsx", sheetName = "GCI 2013-2014")[4:147, 1:3]
wef <- plyr::rename(wef, c("The.Global.Competitiveness.Index.2014.2015.rankings."="Country", "NA."="Ranking_WEF", "NA..1"  = "Score"))
wef$Country <- str_trim(wef$Country, side="both")

# correct names
wef$Country[wef$Country=="Taiwan, China"] <-  "Taiwan"
wef$Country[wef$Country=="Korea, Rep."] <- "Korea"
wef$Country[wef$Country=="Russian Federation"] <- "Russia"

wef$Ranking_WEF <- as.integer(wef$Ranking_WEF)

wef <- subset(wef, Country %in% selectedCountries, select=c(Country, Ranking_WEF, Score))
