library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")

http://data.worldbank.org/indicator/SE.PRM.CMPT.ZS
http://data.worldbank.org/indicator/SE.SEC.CMPT.LO.ZS
http://www.uis.unesco.org/Library/Documents/eiguide09-en.pdf


Korea <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Singapore <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SGP", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
China <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Germany <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Switzerland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SWZ", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Mexico <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__MEX", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Brazil <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__BRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
USA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__USA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UK <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__GBR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UAE <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ARE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Australia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__AUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
SA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ZAF", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Kenya <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KEN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__FIN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Canada <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CAN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Israel <- Quandl("UN/UIS_PUBLICEXPENDITUREONdropoutASOFGDP__ISR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NZL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Japan <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__JPN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Czech <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CZE", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Chile <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Nigeria <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NGA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]


df_dropout <- data.frame(Country = Country, DropoutRate = seq(1,23), stringsAsFactors=FALSE)

df_dropout$dropout[df_dropout$Country == "Korea"] <- Korea
df_dropout$dropout[df_dropout$Country == "Singapore"] <- Singapore #extra
df_dropout$dropout[df_dropout$Country == "China"] <- China
df_dropout$dropout[df_dropout$Country == "Germany"] <- Germany
df_dropout$dropout[df_dropout$Country == "Switzerland"] <- Switzerland
df_dropout$dropout[df_dropout$Country == "Mexico"] <- Mexico
df_dropout$dropout[df_dropout$Country == "Brazil"] <- Brazil
df_dropout$dropout[df_dropout$Country == "Russia"] <- Russia
df_dropout$dropout[df_dropout$Country == "United States"] <- USA
df_dropout$dropout[df_dropout$Country == "United Kingdom"] <- UK
df_dropout$dropout[df_dropout$Country == "United Arab Emirates"] <- UAE
df_dropout$dropout[df_dropout$Country == "Australia"] <- Australia
df_dropout$dropout[df_dropout$Country == "South Africa"] <- SA
df_dropout$dropout[df_dropout$Country == "Kenya"] <- Kenya 
df_dropout$dropout[df_dropout$Country == "Finland"] <- Finland
df_dropout$dropout[df_dropout$Country == "Canada"] <- Canada
df_dropout$dropout[df_dropout$Country == "Israel"] <- Israel
df_dropout$dropout[df_dropout$Country == "New Zealand"] <- NewZeland
df_dropout$dropout[df_dropout$Country == "Jordan"] <- Jordan
df_dropout$dropout[df_dropout$Country == "Czech Republic"] <- Czech
df_dropout$dropout[df_dropout$Country == "Chile"] <- Chile
df_dropout$dropout[df_dropout$Country == "Japan"] <- Japan
df_dropout$dropout[df_dropout$Country == "Nigeria"] <- Nigeria














