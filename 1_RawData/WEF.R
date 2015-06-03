library(stringr)
library(plyr)
library(readxl)

wef <- read_excel("1_RawData/DataSources/GCR_Rankings_2014-2015.xlsx", sheet = "GCI 2013-2014", skip = 3)[1:147, 1:3]
wef <- plyr::rename(wef, c("Country/Economy" = "Country", "Rank (out of 144)"= "Ranking_WEF", "Score" = "WEF_Score"))
wef$Country <- str_trim(wef$Country, side = "both")

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", "Mexico", 
                          "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", 
                          "Finland", "Canada", "Israel", "New Zealand", "France", "Hungary", "Thailand", "Indonesia", "Ghana", "Colombia", "Turkey")

# correct names and convert to numeric
# https://stackoverflow.com/questions/3418128/how-to-convert-a-factor-to-an-integer-numeric-without-a-loss-of-information
wef$Country[wef$Country == "Taiwan, China"] <- "Taiwan"
wef$Country[wef$Country == "Korea, Rep."] <- "Korea"
wef$Country[wef$Country == "Russian Federation"] <- "Russia"

wef <- subset(wef, Country %in% selectedCountries)

wef$WEF_Score_NonScaled <- wef$WEF_Score

