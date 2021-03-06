library(stringr)
library("Quandl")
library(plyr)

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
                          "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
                          "Kenya", "Finland", "Canada", "Israel", "New Zealand")


CompletionRate <- read.csv("1_RawData/DataSources/CompletionRate2.csv")
CompletionRate <- plyr::rename(CompletionRate, c(Country.Name = "Country"))
CompletionRate$Country <- str_trim(CompletionRate$Country, side = "both")
CompletionRate$Country[CompletionRate$Country == "Hong Kong SAR, China"] <- "Hong Kong SAR"
CompletionRate$Country[CompletionRate$Country == "Taiwan, China"] <- "Taiwan"
CompletionRate$Country[CompletionRate$Country == "Korea, Rep."] <- "Korea"
CompletionRate$Country[CompletionRate$Country == "Russian Federation"] <- "Russia"

# Quandl("WORLDBANK/KEN_HH_DHS_PCR", authcode="GgnxpyUBXHsyQxqp67bY")

# Proxy https://www.seab.gov.sg/content/pressReleases/Release_of_2014_PSLE_Results_21112014.pdf
CompletionRate$CompletionRate[CompletionRate$Country == "Singapore"] <- 97.6

CompletionRate$CompletionRate[CompletionRate$Country == "Brazil"] <- CompletionRate$X2004[CompletionRate$Country == "Brazil"]
CompletionRate$CompletionRate[CompletionRate$Country == "Chile"] <- CompletionRate$X2012[CompletionRate$Country == "Chile"]
CompletionRate$CompletionRate[CompletionRate$Country == "Canada"] <- CompletionRate$X2006[CompletionRate$Country == "Canada"]
CompletionRate$CompletionRate[CompletionRate$Country == "China"] <- CompletionRate$X1997[CompletionRate$Country == "China"]
CompletionRate$CompletionRate[CompletionRate$Country == "Czech Republic"] <- CompletionRate$X2012[CompletionRate$Country == "Czech Republic"]
CompletionRate$CompletionRate[CompletionRate$Country == "Finland"] <- CompletionRate$X2012[CompletionRate$Country == "Finland"]
CompletionRate$CompletionRate[CompletionRate$Country == "Germany"] <- CompletionRate$X2012[CompletionRate$Country == "Germany"]
CompletionRate$CompletionRate[CompletionRate$Country == "Israel"] <- CompletionRate$X2012[CompletionRate$Country == "Israel"]
CompletionRate$CompletionRate[CompletionRate$Country == "Japan"] <- CompletionRate$X2012[CompletionRate$Country == "Japan"]
CompletionRate$CompletionRate[CompletionRate$Country == "Jordan"] <- CompletionRate$X2011[CompletionRate$Country == "Jordan"]
CompletionRate$CompletionRate[CompletionRate$Country == "Kenya"] <- CompletionRate$X2005[CompletionRate$Country == "Kenya"]
CompletionRate$CompletionRate[CompletionRate$Country == "Korea"] <- CompletionRate$X2012[CompletionRate$Country == "Korea"]
CompletionRate$CompletionRate[CompletionRate$Country == "Mexico"] <- CompletionRate$X2012[CompletionRate$Country == "Mexico"]

CompletionRate$CompletionRate[CompletionRate$Country == "Nigeria"] <- CompletionRate$X2010[CompletionRate$Country == "Nigeria"]
CompletionRate$CompletionRate[CompletionRate$Country == "Russia"] <- CompletionRate$X2012[CompletionRate$Country == "Russia"]
CompletionRate$CompletionRate[CompletionRate$Country == "South Africa"] <- CompletionRate$X2004[CompletionRate$Country == "South Africa"]
CompletionRate$CompletionRate[CompletionRate$Country == "Switzerland"] <- CompletionRate$X2012[CompletionRate$Country == "Switzerland"]

CompletionRate$CompletionRate[CompletionRate$Country == "United Arab Emirates"] <- CompletionRate$X2012[CompletionRate$Country == "United Arab Emirates"]
# in the new version of CSV file it was gone 
# http://www.tradingeconomics.com/united-states/primary-completion-rate-total-percent-of-relevant-age-group-wb-data.html
CompletionRate$CompletionRate[CompletionRate$Country == "United States"] <- 103.64

# CompletionRate$CompletionRate[CompletionRate$Country == "United States"] <- CompletionRate$X2012[CompletionRate$Country == "United States"]

#' http://www.adb.org/sites/default/files/publication/43030/ki2014-mdg2.pdf
#' https://www.quandl.com/c/society/enrolment-rate-primary-by-country
CompletionRate$CompletionRate[CompletionRate$Country == "Australia"] <- Quandl("WORLDBANK/AUS_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]
CompletionRate$CompletionRate[CompletionRate$Country == "New Zealand"] <- Quandl("WORLDBANK/NZL_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]

#' http://mdgs.un.org/unsd/mdg/Data.aspx 
#' http://mdgs.un.org/unsd/mdg/Handlers/ExportHandler.ashx?Type=Xml&Series=589
#' http://data.worldbank.org/indicator/SE.PRM.NENR/countries
#' https://www.quandl.com/c/society/enrolment-rate-primary-by-country
CompletionRate$CompletionRate[CompletionRate$Country == "United Kingdom"] <- Quandl("WORLDBANK/GBR_SE_PRM_ENRR", authcode = "GgnxpyUBXHsyQxqp67bY")[1,2]

CompletionRate <- subset(CompletionRate, Country %in% selectedCountries, select = c(Country, CompletionRate))

CompletionRate$CompletionRate_NonScaled <- CompletionRate$CompletionRate
CompletionRate$CompletionRate <- as.numeric(scale(CompletionRate$CompletionRate_NonScaled))

sapply(CompletionRate, class)
# CompletionRate$CompletionRate_Scaled <- scale(CompletionRate$CompletionRate)


