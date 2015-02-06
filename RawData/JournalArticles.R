library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")


Korea <- Quandl("WORLDBANK/KOR_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
China <- Quandl("WORLDBANK/CHN_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Germany <- Quandl("WORLDBANK/DEU_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Switzerland <- Quandl("WORLDBANK/CHE_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Mexico <- Quandl("WORLDBANK/MEX_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Brazil <- Quandl("WORLDBANK/BRA_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("WORLDBANK/RUS_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
USA <-  Quandl("WORLDBANK/USA_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UK <- Quandl("WORLDBANK/GBR_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Singapore <- Quandl("WORLDBANK/SGP_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UAE <- Quandl("WORLDBANK/ARE_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Kenya <- Quandl("WORLDBANK/KEN_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("WORLDBANK/FIN_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Canada <- Quandl("WORLDBANK/CAN_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Israel <- Quandl("WORLDBANK/ISR_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("WORLDBANK/NZL_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Jordan <- Quandl("WORLDBANK/JOR_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Czech <- Quandl("WORLDBANK/CZE_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Japan <- Quandl("WORLDBANK/JPN_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Chile <- Quandl("WORLDBANK/CHL_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Nigeria <- Quandl("WORLDBANK/NGA_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Australia <- Quandl("WORLDBANK/AUS_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
SA <- Quandl("WORLDBANK/ZAF_IP_JRN_ARTC_SC", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]

Journals <- data.frame(Country = Country, JournalArticles = seq(1,23), stringsAsFactors=FALSE)

Journals$JournalArticles[Journals$Country == "Korea"] <- Korea
Journals$JournalArticles[Journals$Country == "Singapore"] <- Singapore
Journals$JournalArticles[Journals$Country == "China"] <- China
Journals$JournalArticles[Journals$Country == "Germany"] <- Germany
Journals$JournalArticles[Journals$Country == "Switzerland"] <- Switzerland
Journals$JournalArticles[Journals$Country == "Mexico"] <- Mexico
Journals$JournalArticles[Journals$Country == "Brazil"] <- Brazil
Journals$JournalArticles[Journals$Country == "Russia"] <- Russia
Journals$JournalArticles[Journals$Country == "United States"] <- USA
Journals$JournalArticles[Journals$Country == "United Kingdom"] <- UK
Journals$JournalArticles[Journals$Country == "United Arab Emirates"] <- UAE
Journals$JournalArticles[Journals$Country == "Australia"] <- Australia
Journals$JournalArticles[Journals$Country == "South Africa"] <- SA
Journals$JournalArticles[Journals$Country == "Kenya"] <- Kenya 
Journals$JournalArticles[Journals$Country == "Finland"] <- Finland
Journals$JournalArticles[Journals$Country == "Canada"] <- Canada
Journals$JournalArticles[Journals$Country == "Israel"] <- Israel
Journals$JournalArticles[Journals$Country == "New Zealand"] <- NewZeland

Journals$JournalArticles[Journals$Country == "Jordan"] <- Jordan
Journals$JournalArticles[Journals$Country == "Czech Republic"] <- Czech
Journals$JournalArticles[Journals$Country == "Chile"] <- Chile
Journals$JournalArticles[Journals$Country == "Japan"] <- Japan
Journals$JournalArticles[Journals$Country == "Nigeria"] <- Nigeria





