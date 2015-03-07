library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")


Korea <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Singapore manual
China <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Germany <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Switzerland <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__SWZ", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Mexico <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__MEX", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Brazil <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__BRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
USA <-  Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__USA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# UK Manual
# UK <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__GBR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/335413/sfr11_2014_updated_july.pdf
UAE <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__ARE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Ausee manual
# South Africa manual http://www.iol.co.za/capetimes/cape-pupil-teacher-ratios-on-par-1.1359824
Kenya <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__FIN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Canada Manual
# http://www.cmec.ca/Publications/Lists/Publications/Attachments/300/EAG_2013_Canada_EN.pdf
# Canada <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CAN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Israel manual
# https://www.oecd.org/edu/EAG2014-Indicator%20D2%20%28eng%29.pdf
# Israel <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__ISR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__NZL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# Jordan manual http://jordantimes.com/student-teacher-ratio-in-public-schools-within-intl-standards
#Jordan <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__JOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Czech <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CZE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Japan <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__JPN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Chile <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__CHL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Nigeria <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__NGA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]

df_education <- data.frame(Country = Country, TSR = seq(1,23), stringsAsFactors=FALSE)

df_education$TSR[df_education$Country == "Korea"] <- Korea
df_education$TSR[df_education$Country == "Singapore"] <- 13.2 #extra
df_education$TSR[df_education$Country == "China"] <- China
df_education$TSR[df_education$Country == "Germany"] <- Germany
df_education$TSR[df_education$Country == "Switzerland"] <- Switzerland
df_education$TSR[df_education$Country == "Mexico"] <- Mexico
df_education$TSR[df_education$Country == "Brazil"] <- Brazil
df_education$TSR[df_education$Country == "Russia"] <- Russia
df_education$TSR[df_education$Country == "United States"] <- USA
df_education$TSR[df_education$Country == "United Kingdom"] <- 17.2
df_education$TSR[df_education$Country == "United Arab Emirates"] <- UAE
df_education$TSR[df_education$Country == "Australia"] <- 12 #extra oecd
df_education$TSR[df_education$Country == "South Africa"] <- 34
df_education$TSR[df_education$Country == "Kenya"] <- Kenya 
df_education$TSR[df_education$Country == "Finland"] <- Finland
df_education$TSR[df_education$Country == "Canada"] <- 15.3
df_education$TSR[df_education$Country == "Israel"] <- 12
df_education$TSR[df_education$Country == "New Zealand"] <- NewZeland

df_education$TSR[df_education$Country == "Jordan"] <- 16
df_education$TSR[df_education$Country == "Czech Republic"] <- Czech
df_education$TSR[df_education$Country == "Chile"] <- Chile
df_education$TSR[df_education$Country == "Japan"] <- Japan
df_education$TSR[df_education$Country == "Nigeria"] <- Nigeria





