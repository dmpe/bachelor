library(stringr)
library("Quandl")
library(plyr)

# 
# Country =  c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")

# http://data.worldbank.org/indicator/SE.PRM.CMPT.ZS
# http://data.worldbank.org/indicator/SE.SEC.CMPT.LO.ZS
# http://www.uis.unesco.org/Library/Documents/eiguide09-en.pdf

# 
# Korea <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Singapore <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SGP", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# China <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Germany <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Switzerland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SWZ", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Mexico <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__MEX", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Brazil <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__BRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Russia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# USA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__USA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# UK <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__GBR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# UAE <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ARE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Australia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__AUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# SA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ZAF", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Kenya <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Finland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__FIN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Canada <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CAN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Israel <- Quandl("WORLDBANK/ISR_GER_PRI_CMPT_TOT", trim_start="2010-12-31", trim_end="2013-12-31", authcode="GgnxpyUBXHsyQxqp67bY")[3,2]
# NewZeland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NZL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Japan <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__JPN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Czech <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CZE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Chile <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Nigeria <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NGA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Jordan <- Quandl("WORLDBANK/JOR_GER_PRI_CMPT_TOT", trim_start="2010-12-31", trim_end="2013-12-31", authcode="GgnxpyUBXHsyQxqp67bY")[3,2]
# 
# df_dropout <- data.frame(Country = Country, DropoutRate = seq(1,23), stringsAsFactors=FALSE)
# 
# df_dropout$dropout[df_dropout$Country == "Jordan"] <- Jordan
# df_dropout$dropout[df_dropout$Country == "Korea"] <- Korea
# df_dropout$dropout[df_dropout$Country == "Singapore"] <- Singapore #extra
# df_dropout$dropout[df_dropout$Country == "China"] <- China
# df_dropout$dropout[df_dropout$Country == "Germany"] <- Germany
# df_dropout$dropout[df_dropout$Country == "Switzerland"] <- Switzerland
# df_dropout$dropout[df_dropout$Country == "Mexico"] <- Mexico
# df_dropout$dropout[df_dropout$Country == "Brazil"] <- Brazil
# df_dropout$dropout[df_dropout$Country == "Russia"] <- Russia
# df_dropout$dropout[df_dropout$Country == "United States"] <- USA
# df_dropout$dropout[df_dropout$Country == "United Kingdom"] <- UK
# df_dropout$dropout[df_dropout$Country == "United Arab Emirates"] <- UAE
# df_dropout$dropout[df_dropout$Country == "Australia"] <- Australia
# df_dropout$dropout[df_dropout$Country == "South Africa"] <- SA
# df_dropout$dropout[df_dropout$Country == "Kenya"] <- Kenya 
# df_dropout$dropout[df_dropout$Country == "Finland"] <- Finland
# df_dropout$dropout[df_dropout$Country == "Canada"] <- Canada
# df_dropout$dropout[df_dropout$Country == "Israel"] <- Israel
# df_dropout$dropout[df_dropout$Country == "New Zealand"] <- NewZeland
# df_dropout$dropout[df_dropout$Country == "Jordan"] <- Jordan
# df_dropout$dropout[df_dropout$Country == "Czech Republic"] <- Czech
# df_dropout$dropout[df_dropout$Country == "Chile"] <- Chile
# df_dropout$dropout[df_dropout$Country == "Japan"] <- Japan
# df_dropout$dropout[df_dropout$Country == "Nigeria"] <- Nigeria



CompletionRate <- read.csv("RawData/DataSources/CompletionRate.csv")
CompletionRate <- plyr::rename(CompletionRate, c("Country.Name"="Country"))
CompletionRate$Country <- str_trim(CompletionRate$Country, side="both")
CompletionRate$Country[CompletionRate$Country=="Hong Kong SAR, China"] <-  "Hong Kong SAR"
CompletionRate$Country[CompletionRate$Country=="Taiwan, China"] <-  "Taiwan"
CompletionRate$Country[CompletionRate$Country=="Korea, Rep."] <-  "Korea"
CompletionRate$Country[CompletionRate$Country=="Russian Federation"] <- "Russia"


CompletionRate$CompletionRate[CompletionRate$Country == "Korea"] <- CompletionRate$X2012[CompletionRate$Country == "Korea"]
# Proxy https://www.seab.gov.sg/content/pressReleases/Release_of_2014_PSLE_Results_21112014.pdf
CompletionRate$CompletionRate[CompletionRate$Country == "Singapore"] <- 97.6
CompletionRate$CompletionRate[CompletionRate$Country == "China"] <- CompletionRate$X1997[CompletionRate$Country == "China"]
CompletionRate$CompletionRate[CompletionRate$Country == "Germany"] <- CompletionRate$X2012[CompletionRate$Country == "Germany"]
CompletionRate$CompletionRate[CompletionRate$Country == "Switzerland"] <- CompletionRate$X2012[CompletionRate$Country == "Switzerland"]
CompletionRate$CompletionRate[CompletionRate$Country == "Mexico"] <- CompletionRate$X2012[CompletionRate$Country == "Mexico"]
CompletionRate$CompletionRate[CompletionRate$Country == "Brazil"] <- CompletionRate$X1994[CompletionRate$Country == "Brazil"] 
CompletionRate$CompletionRate[CompletionRate$Country == "Russia"] <- CompletionRate$X2012[CompletionRate$Country == "Russia"]
CompletionRate$CompletionRate[CompletionRate$Country == "United States"] <- CompletionRate$X2012[CompletionRate$Country == "United States"]
CompletionRate$CompletionRate[CompletionRate$Country == "United Arab Emirates"] <- CompletionRate$X2012[CompletionRate$Country == "United Arab Emirates"]
CompletionRate$CompletionRate[CompletionRate$Country == "South Africa"] <- CompletionRate$X2004[CompletionRate$Country == "South Africa"]
CompletionRate$CompletionRate[CompletionRate$Country == "Kenya"] <- CompletionRate$X2005[CompletionRate$Country == "Kenya"]
CompletionRate$CompletionRate[CompletionRate$Country == "Finland"] <- CompletionRate$X2012[CompletionRate$Country == "Finland"]
CompletionRate$CompletionRate[CompletionRate$Country == "Canada"] <- CompletionRate$X2006[CompletionRate$Country == "Canada"]
CompletionRate$CompletionRate[CompletionRate$Country == "Israel"] <- CompletionRate$X2011[CompletionRate$Country == "Israel"]
CompletionRate$CompletionRate[CompletionRate$Country == "Jordan"] <- CompletionRate$X2011[CompletionRate$Country == "Jordan"]
CompletionRate$CompletionRate[CompletionRate$Country == "Czech Republic"] <- CompletionRate$X2012[CompletionRate$Country == "Czech Republic"]
CompletionRate$CompletionRate[CompletionRate$Country == "Chile"] <- CompletionRate$X2012[CompletionRate$Country == "Chile"]
CompletionRate$CompletionRate[CompletionRate$Country == "Japan"] <- CompletionRate$X2012[CompletionRate$Country == "Japan"]
CompletionRate$CompletionRate[CompletionRate$Country == "Nigeria"] <- CompletionRate$X2010[CompletionRate$Country == "Nigeria"]

CompletionRate$CompletionRate[CompletionRate$Country == "Australia"] <- 99
CompletionRate$CompletionRate[CompletionRate$Country == "New Zealand"] <- 99
CompletionRate$CompletionRate[CompletionRate$Country == "United Kingdom"] <- 99



CompletionRate <- subset(CompletionRate, Country %in% selectedCountries, select=c(Country, CompletionRate))
