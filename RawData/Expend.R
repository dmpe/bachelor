library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country =  c('Korea','Singapore','China', "Germany", "France", "Mexico", "Brazil", "Russia", 
             "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", "Finland", "Canada", "Israel", "New Zealand")

Korea <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Singapore <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SGP", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# China manual - http://news.xinhuanet.com/english/china/2013-01/04/c_132080607.htm
# China <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
# germany manula 
# https://www.destatis.de/EN/FactsFigures/SocietyState/EducationResearchCulture/EducationalCulturalFinance/Tables/Budget.html
# Germany <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
France <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__FRA", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
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
# Israel manual
# http://www1.cbs.gov.il/shnaton65/st08_75.pdf
# Israel <- Quandl("UN/UIS_PUBLICEXPENDITUREONexpendituresASOFGDP__ISR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
NewZeland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NZL", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]

df_expenditures <- data.frame(Country = Country, Expenditures = seq(1,18), stringsAsFactors=FALSE)

df_expenditures$Expenditures[df_expenditures$Country == "Korea"] <- Korea
df_expenditures$Expenditures[df_expenditures$Country == "Singapore"] <- Singapore #extra
df_expenditures$Expenditures[df_expenditures$Country == "China"] <- 3.93
df_expenditures$Expenditures[df_expenditures$Country == "Germany"] <- 6.5
df_expenditures$Expenditures[df_expenditures$Country == "France"] <- France
df_expenditures$Expenditures[df_expenditures$Country == "Mexico"] <- Mexico
df_expenditures$Expenditures[df_expenditures$Country == "Brazil"] <- Brazil
df_expenditures$Expenditures[df_expenditures$Country == "Russia"] <- Russia
df_expenditures$Expenditures[df_expenditures$Country == "United States"] <- USA
df_expenditures$Expenditures[df_expenditures$Country == "United Kingdom"] <- UK
df_expenditures$Expenditures[df_expenditures$Country == "United Arab Emirates"] <- UAE
df_expenditures$Expenditures[df_expenditures$Country == "Australia"] <- Australia
df_expenditures$Expenditures[df_expenditures$Country == "South Africa"] <- SA
df_expenditures$Expenditures[df_expenditures$Country == "Kenya"] <- Kenya 
df_expenditures$Expenditures[df_expenditures$Country == "Finland"] <- Finland
df_expenditures$Expenditures[df_expenditures$Country == "Canada"] <- Canada
df_expenditures$Expenditures[df_expenditures$Country == "Israel"] <- 7.3
df_expenditures$Expenditures[df_expenditures$Country == "New Zeland"] <- NewZeland
