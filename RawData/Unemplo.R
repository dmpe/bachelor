library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', "Germany", "Switzerland", "Mexico", 'Jordan', "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya","Finland", "Canada", "Israel", "New Zealand")


Korea <- Quandl("WORLDBANK/KOR_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
China <- Quandl("WORLDBANK/CHN_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Germany <- Quandl("WORLDBANK/DEU_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Switzerland <- Quandl("WORLDBANK/CHE_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Mexico <- Quandl("WORLDBANK/MEX_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Brazil <- Quandl("WORLDBANK/BRA_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("WORLDBANK/RUS_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
USA <-  Quandl("WORLDBANK/USA_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UAE <- Quandl("WORLDBANK/ARE_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Kenya <- Quandl("WORLDBANK/KEN_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Finland <- Quandl("WORLDBANK/FIN_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("WORLDBANK/NZL_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Czech <- Quandl("WORLDBANK/CZE_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Japan <- Quandl("WORLDBANK/JPN_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Chile <- Quandl("WORLDBANK/CHL_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Nigeria <- Quandl("WORLDBANK/NGA_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
SA <- Quandl("WORLDBANK/ZAF_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Canada <- Quandl("WORLDBANK/CAN_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Australia <- Quandl("WORLDBANK/AUS_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
UK <- Quandl("WORLDBANK/GBR_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Jordan <- Quandl("WORLDBANK/JOR_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Israel <- Quandl("WORLDBANK/ISR_SL_UEM_TOTL_ZS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]

df_unemp <- data.frame(Country = Country, Unemployment = seq(1,23), stringsAsFactors=FALSE)

df_unemp$Unemployment[df_unemp$Country == "Korea"] <- Korea
df_unemp$Unemployment[df_unemp$Country == "Singapore"] <- Singapore
df_unemp$Unemployment[df_unemp$Country == "China"] <- China
df_unemp$Unemployment[df_unemp$Country == "Germany"] <- Germany
df_unemp$Unemployment[df_unemp$Country == "Switzerland"] <- Switzerland
df_unemp$Unemployment[df_unemp$Country == "Mexico"] <- Mexico
df_unemp$Unemployment[df_unemp$Country == "Brazil"] <- Brazil
df_unemp$Unemployment[df_unemp$Country == "Russia"] <- Russia
df_unemp$Unemployment[df_unemp$Country == "United States"] <- USA
df_unemp$Unemployment[df_unemp$Country == "United Kingdom"] <- UK
df_unemp$Unemployment[df_unemp$Country == "United Arab Emirates"] <- UAE
df_unemp$Unemployment[df_unemp$Country == "Australia"] <- Australia
df_unemp$Unemployment[df_unemp$Country == "South Africa"] <- SA
df_unemp$Unemployment[df_unemp$Country == "Kenya"] <- Kenya 
df_unemp$Unemployment[df_unemp$Country == "Finland"] <- Finland
df_unemp$Unemployment[df_unemp$Country == "Canada"] <- Canada
df_unemp$Unemployment[df_unemp$Country == "Israel"] <- Israel
df_unemp$Unemployment[df_unemp$Country == "New Zealand"] <- NewZeland

df_unemp$Unemployment[df_unemp$Country == "Jordan"] <- Jordan
df_unemp$Unemployment[df_unemp$Country == "Czech Republic"] <- Czech
df_unemp$Unemployment[df_unemp$Country == "Chile"] <- Chile
df_unemp$Unemployment[df_unemp$Country == "Japan"] <- Japan
df_unemp$Unemployment[df_unemp$Country == "Nigeria"] <- Nigeria

