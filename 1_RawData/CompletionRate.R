library(stringr)
library("Quandl")
library(plyr)

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
                          "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
                          "Kenya", "Finland", "Canada", "Israel", "New Zealand")


completionRate <- read.csv("1_RawData/DataSources/CompletionRate.csv")
completionRate <- plyr::rename(completionRate, c(Country.Name = "Country"))
completionRate$Country <- str_trim(completionRate$Country, side = "both")
completionRate$Country[completionRate$Country == "Hong Kong SAR, China"] <- "Hong Kong SAR"
completionRate$Country[completionRate$Country == "Taiwan, China"] <- "Taiwan"
completionRate$Country[completionRate$Country == "Korea, Rep."] <- "Korea"
completionRate$Country[completionRate$Country == "Russian Federation"] <- "Russia"

completionRate$completionRate[completionRate$Country == "Korea"] <- completionRate$X2012[completionRate$Country == "Korea"]
# Proxy https://www.seab.gov.sg/content/pressReleases/Release_of_2014_PSLE_Results_21112014.pdf
completionRate$completionRate[completionRate$Country == "Singapore"] <- 97.6

completionRate$completionRate[completionRate$Country == "China"] <- completionRate$X1997[completionRate$Country == "China"]
completionRate$completionRate[completionRate$Country == "Germany"] <- completionRate$X2012[completionRate$Country == "Germany"]
completionRate$completionRate[completionRate$Country == "Switzerland"] <- completionRate$X2012[completionRate$Country == "Switzerland"]
completionRate$completionRate[completionRate$Country == "Mexico"] <- completionRate$X2012[completionRate$Country == "Mexico"]
completionRate$completionRate[completionRate$Country == "Brazil"] <- completionRate$X1994[completionRate$Country == "Brazil"]
completionRate$completionRate[completionRate$Country == "Russia"] <- completionRate$X2012[completionRate$Country == "Russia"]
completionRate$completionRate[completionRate$Country == "United States"] <- completionRate$X2012[completionRate$Country == 
    "United States"]
completionRate$completionRate[completionRate$Country == "United Arab Emirates"] <- completionRate$X2012[completionRate$Country == 
    "United Arab Emirates"]
completionRate$completionRate[completionRate$Country == "South Africa"] <- completionRate$X2004[completionRate$Country == "South Africa"]
completionRate$completionRate[completionRate$Country == "Kenya"] <- completionRate$X2005[completionRate$Country == "Kenya"]
completionRate$completionRate[completionRate$Country == "Finland"] <- completionRate$X2012[completionRate$Country == "Finland"]
completionRate$completionRate[completionRate$Country == "Canada"] <- completionRate$X2006[completionRate$Country == "Canada"]
completionRate$completionRate[completionRate$Country == "Israel"] <- completionRate$X2011[completionRate$Country == "Israel"]
completionRate$completionRate[completionRate$Country == "Jordan"] <- completionRate$X2011[completionRate$Country == "Jordan"]
completionRate$completionRate[completionRate$Country == "Czech Republic"] <- completionRate$X2012[completionRate$Country == 
    "Czech Republic"]
completionRate$completionRate[completionRate$Country == "Chile"] <- completionRate$X2012[completionRate$Country == "Chile"]
completionRate$completionRate[completionRate$Country == "Japan"] <- completionRate$X2012[completionRate$Country == "Japan"]
completionRate$completionRate[completionRate$Country == "Nigeria"] <- completionRate$X2010[completionRate$Country == "Nigeria"]

#' http://www.adb.org/sites/default/files/publication/43030/ki2014-mdg2.pdf
#' https://www.quandl.com/c/society/enrolment-rate-primary-by-country
completionRate$completionRate[completionRate$Country == "Australia"] <- Quandl("WORLDBANK/AUS_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]
completionRate$completionRate[completionRate$Country == "New Zealand"] <- Quandl("WORLDBANK/NZL_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]

#' http://mdgs.un.org/unsd/mdg/Data.aspx 
#' http://mdgs.un.org/unsd/mdg/Handlers/ExportHandler.ashx?Type=Xml&Series=589
#' http://data.worldbank.org/indicator/SE.PRM.NENR/countries
#' https://www.quandl.com/c/society/enrolment-rate-primary-by-country
completionRate$completionRate[completionRate$Country == "United Kingdom"] <- Quandl("WORLDBANK/GBR_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]

completionRate <- subset(completionRate, Country %in% selectedCountries, select = c(Country, completionRate))

completionRate$completionRate_NonScaled <- completionRate$completionRate
completionRate$completionRate <- as.numeric(scale(completionRate$completionRate_NonScaled))

sapply(completionRate, class)
# completionRate$completionRate_Scaled <- scale(completionRate$completionRate)



 
