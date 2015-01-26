library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore','China', "Germany", "France", "Mexico", "Brazil", "Russia", 
             "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", "Finland", "Canada", "Israel", "New Zealand")

Germany <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Korea <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
France <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__FRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Brazil <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__BRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Mexico <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__MEX", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Israel <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__ISR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__FIN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Canada <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CAN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
China <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Kenya <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
USA <-  Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__USA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]

# UK <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__GBR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/335413/sfr11_2014_updated_july.pdf

df_education <- data.frame(Country = Country, TSR = seq(1,18), stringsAsFactors=FALSE)

df_education$TSR[df_education$Country == "Singapore"] <- 13.2 #extra
df_education$TSR[df_education$Country == "Korea"] <- Korea
df_education$TSR[df_education$Country == "China"] <- China
df_education$TSR[df_education$Country == "Germany"] <- Germany
df_education$TSR[df_education$Country == "France"] <- France
df_education$TSR[df_education$Country == "Mexico"] <- Mexico
df_education$TSR[df_education$Country == "Brazil"] <- Brazil
df_education$TSR[df_education$Country == "Russia"] <- Russia
df_education$TSR[df_education$Country == "Finland"] <- Finland
df_education$TSR[df_education$Country == "Canada"] <- Canada
df_education$TSR[df_education$Country == "Australia"] <- 12 #extra oecd
df_education$TSR[df_education$Country == "Kenya"] <- Kenya 
df_education$TSR[df_education$Country == "New Zeland"] <- NewZeland
df_education$TSR[df_education$Country == "United States"] <- USA
df_education$TSR[df_education$Country == "United Kingdom"] <- 17.2






