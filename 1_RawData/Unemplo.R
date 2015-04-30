library(Quandl)

Country = c("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", "Mexico", 
            "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", 
            "Finland", "Canada", "Israel", "New Zealand")

selectedCountries <- list("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
                          "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
                          "Kenya", "Finland", "Canada", "Israel", "New Zealand")

# see Quandl emails
Korea <- Quandl("WORLDBANK/KOR_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
# http://api.worldbank.org/countries/CHN/indicators/SL.UEM.1524.ZS?per_page=1000
# China <- Quandl('WORLDBANK/CHN_SL_UEM_1524_ZS', authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
China <- 10.1
Germany <- Quandl("WORLDBANK/DEU_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Switzerland <- Quandl("WORLDBANK/CHE_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Mexico <- Quandl("WORLDBANK/MEX_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Brazil <- Quandl("WORLDBANK/BRA_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Russia <- Quandl("WORLDBANK/RUS_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
USA <- Quandl("WORLDBANK/USA_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
UAE <- Quandl("WORLDBANK/ARE_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
# http://api.worldbank.org/countries/KEN/indicators/SL.UEM.1524.ZS?per_page=1000
# Kenya <- Quandl('WORLDBANK/KEN_SL_UEM_1524_ZS', authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Kenya <- 17.1
Finland <- Quandl("WORLDBANK/FIN_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
NewZeland <- Quandl("WORLDBANK/NZL_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Czech <- Quandl("WORLDBANK/CZE_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Japan <- Quandl("WORLDBANK/JPN_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Chile <- Quandl("WORLDBANK/CHL_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Nigeria <- Quandl("WORLDBANK/NGA_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
SA <- Quandl("WORLDBANK/ZAF_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Canada <- Quandl("WORLDBANK/CAN_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Australia <- Quandl("WORLDBANK/AUS_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
UK <- Quandl("WORLDBANK/GBR_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Jordan <- Quandl("WORLDBANK/JOR_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Israel <- Quandl("WORLDBANK/ISR_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Singapore <- Quandl("WORLDBANK/SGP_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]

France <- Quandl("WORLDBANK/FRA_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Indonesia <- Quandl("WORLDBANK/IDN_SL_UEM_1524_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Turkey <- Quandl("WORLDBANK/TUR_SL_UEM_1524_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Hungary <- Quandl("WORLDBANK/HUN_SL_UEM_1524_ZS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Ghana <- Quandl("WORLDBANK/GHA_SL_UEM_1524_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Thailand <- Quandl("WORLDBANK/THA_SL_UEM_1524_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]
Columbia <- Quandl("WORLDBANK/COL_SL_UEM_1524_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1, 2]


unemplo <- data.frame(Country = Country, Unemployment_NonScaled = seq(1, 35), stringsAsFactors = FALSE)
# Unemployment = seq(1, 23),
unemplo$Unemployment_NonScaled[unemplo$Country == "Korea"] <- Korea
unemplo$Unemployment_NonScaled[unemplo$Country == "Singapore"] <- Singapore
unemplo$Unemployment_NonScaled[unemplo$Country == "China"] <- China
unemplo$Unemployment_NonScaled[unemplo$Country == "Germany"] <- Germany
unemplo$Unemployment_NonScaled[unemplo$Country == "Switzerland"] <- Switzerland
unemplo$Unemployment_NonScaled[unemplo$Country == "Mexico"] <- Mexico
unemplo$Unemployment_NonScaled[unemplo$Country == "Brazil"] <- Brazil
unemplo$Unemployment_NonScaled[unemplo$Country == "Russia"] <- Russia
unemplo$Unemployment_NonScaled[unemplo$Country == "United States"] <- USA
unemplo$Unemployment_NonScaled[unemplo$Country == "United Kingdom"] <- UK
unemplo$Unemployment_NonScaled[unemplo$Country == "United Arab Emirates"] <- UAE
unemplo$Unemployment_NonScaled[unemplo$Country == "Australia"] <- Australia
unemplo$Unemployment_NonScaled[unemplo$Country == "South Africa"] <- SA
unemplo$Unemployment_NonScaled[unemplo$Country == "Kenya"] <- Kenya
unemplo$Unemployment_NonScaled[unemplo$Country == "Finland"] <- Finland
unemplo$Unemployment_NonScaled[unemplo$Country == "Canada"] <- Canada
unemplo$Unemployment_NonScaled[unemplo$Country == "Israel"] <- Israel
unemplo$Unemployment_NonScaled[unemplo$Country == "New Zealand"] <- NewZeland
unemplo$Unemployment_NonScaled[unemplo$Country == "Jordan"] <- Jordan
unemplo$Unemployment_NonScaled[unemplo$Country == "Czech Republic"] <- Czech
unemplo$Unemployment_NonScaled[unemplo$Country == "Chile"] <- Chile
unemplo$Unemployment_NonScaled[unemplo$Country == "Japan"] <- Japan
unemplo$Unemployment_NonScaled[unemplo$Country == "Nigeria"] <- Nigeria

unemplo$Unemployment_NonScaled[unemplo$Country == "France"] <- France
unemplo$Unemployment_NonScaled[unemplo$Country == "Ghana"] <- Ghana
unemplo$Unemployment_NonScaled[unemplo$Country == "Indonesia"] <- Indonesia
unemplo$Unemployment_NonScaled[unemplo$Country == "Columbia"] <- Columbia
unemplo$Unemployment_NonScaled[unemplo$Country == "Turkey"] <- Turkey
unemplo$Unemployment_NonScaled[unemplo$Country == "Hungary"] <- Hungary
unemplo$Unemployment_NonScaled[unemplo$Country == "Thailand"] <- Thailand


# unemplo$Unemployment_MinMax = ((100-0)*(unemplo$Unemployment_NonScaled-max(unemplo$Unemployment_NonScaled))/
#                                       (min(unemplo$Unemployment_NonScaled)-max(unemplo$Unemployment_NonScaled))) + 0

unemplo$Unemployment <- as.numeric(scale(unemplo$Unemployment_NonScaled))
unemplo$Unemployment_ZscoreNEGATIVE <- as.numeric(-scale(unemplo$Unemployment_NonScaled))

unemplo <- plyr::arrange(unemplo, unemplo$Country)

sapply(unemplo, class) 
