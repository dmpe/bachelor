library(stringr)
library(plyr)
library(rvest)


EDB <- html("http://www.doingbusiness.org/rankings")
easydb <- EDB %>% html_node(".table-wrap table") %>% html_table()

easydb <- plyr::rename(easydb, c(`Ease of Doing Business Rank ▲` = "Ranking_EDB", Economy = "Country"))
easydb$Country <- str_replace_all(easydb$Country, "[*]", "")
easydb$Country <- str_trim(easydb$Country, side = "both")
easydb$Country[easydb$Country == "Hong Kong SAR, China"] <- "Hong Kong SAR"
easydb$Country[easydb$Country == "Taiwan, China"] <- "Taiwan"
easydb$Country[easydb$Country == "Korea, Rep."] <- "Korea"
easydb$Country[easydb$Country == "Russian Federation"] <- "Russia"

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
    "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
    "Kenya", "Finland", "Canada", "Israel", "New Zealand")

easydb <- subset(easydb, Country %in% selectedCountries)[, 1:2]
 
