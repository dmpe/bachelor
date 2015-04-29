library(Quandl)

Country = c("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", "Mexico", 
            "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", 
            "Finland", "Canada", "Israel", "New Zealand")

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
                          "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
                          "Kenya", "Finland", "Canada", "Israel", "New Zealand")

Korea <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
China <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Germany <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Switzerland <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_CHE", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Mexico <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_MEX", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Brazil <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_BRA", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Russia <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
USA <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_USA", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
UAE <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_ARE", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Kenya <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_FIN", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
NewZeland <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_NZL", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Czech <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_CZE", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Japan <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_JPN", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Chile <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_CHL", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Nigeria <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_NGA", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
SA <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_ZAF", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Canada <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_CAN", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Australia <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_AUS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
UK <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_GBR", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Jordan <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_JOR", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Israel <- Quandl("UN/UIS_COMBINEDGROSSENROLMENTRATIOPRIMARYTOTERTIARYISCED16__ALLGENDERS_ISR", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
# http://data.gov.sg/Metadata/SGMatadata.aspx?id=0301010000000010018H&mid=154367&t=TEXTUAL
Singapore <- Israel <- 108.9


grossEnrolRate <- data.frame(Country = Country, grossEnrolRate = seq(1, 23), stringsAsFactors = FALSE)

grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Korea"] <- Korea
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Singapore"] <- Singapore
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "China"] <- China
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Germany"] <- Germany
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Switzerland"] <- Switzerland
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Mexico"] <- Mexico
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Brazil"] <- Brazil
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Russia"] <- Russia
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "United States"] <- USA
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "United Kingdom"] <- UK
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "United Arab Emirates"] <- UAE
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Australia"] <- Australia
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "South Africa"] <- SA
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Kenya"] <- Kenya
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Finland"] <- Finland
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Canada"] <- Canada
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Israel"] <- Israel
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "New Zealand"] <- NewZeland
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Jordan"] <- Jordan
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Czech Republic"] <- Czech
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Chile"] <- Chile
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Japan"] <- Japan
grossEnrolRate$grossEnrolRate[grossEnrolRate$Country == "Nigeria"] <- Nigeria


# grossEnrolRate$Unemployment_MinMax = ((100-0)*(grossEnrolRate$grossEnrolRate-max(grossEnrolRate$grossEnrolRate))/
#                                       (min(grossEnrolRate$grossEnrolRate)-max(grossEnrolRate$grossEnrolRate))) + 0

# grossEnrolRate$grossEnrolRate <- as.numeric(scale(grossEnrolRate$grossEnrolRate))
# grossEnrolRate$grossEnrolRate_ZscoreNEGATIVE <- as.numeric(-scale(grossEnrolRate$grossEnrolRate))

# grossEnrolRate <- plyr::arrange(grossEnrolRate, grossEnrolRate$Country)

sapply(grossEnrolRate, class) 
