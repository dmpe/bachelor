library(stringr)
library("Quandl")
library(plyr)
library(dplyr)

Country = c("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", "Mexico", 
    "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", "Kenya", 
    "Finland", "Canada", "Israel", "New Zealand")

Korea <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KOR", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Singapore <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SGP", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
# China manual - http://news.xinhuanet.com/english/china/2013-01/04/c_132080607.htm China <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHN', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] germany manula
# https://www.destatis.de/EN/FactsFigures/SocietyState/EducationResearchCulture/EducationalCulturalFinance/Tables/Budget.html
# Germany <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__DEU', authcode='GgnxpyUBXHsyQxqp67bY')[1,2]
Switzerland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SWZ", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Mexico <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__MEX", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Brazil <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__BRA", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Russia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__RUS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
USA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__USA", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
UK <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__GBR", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
UAE <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ARE", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Australia <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__AUS", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
SA <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ZAF", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Kenya <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KEN", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]

Finland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__FIN", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Canada <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CAN", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
# Israel manual http://www1.cbs.gov.il/shnaton65/st08_75.pdf Israel <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONexpendituresASOFGDP__ISR', authcode='GgnxpyUBXHsyQxqp67bY')[1,2]
NewZeland <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NZL", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]

Japan <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__JPN", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Czech <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CZE", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
Chile <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHL", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]
# manual entry http://www.scielo.org.pe/scielo.php?pid=S2077-18862011000200002&script=sci_arttext
Nigeria <- Quandl("UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NGA", authcode = "GgnxpyUBXHsyQxqp67bY")[1, 2]

# Jordan > http://www.frp2.org/english/Portals/0/PDFs/Education%20PEP%20Working%20Paper.pdf



df_expenditures <- data.frame(Country = Country, Expenditures = seq(1, 23), stringsAsFactors = FALSE)

df_expenditures$Expenditures[df_expenditures$Country == "Korea"] <- Korea
df_expenditures$Expenditures[df_expenditures$Country == "Singapore"] <- Singapore  #extra
df_expenditures$Expenditures[df_expenditures$Country == "China"] <- 3.93
df_expenditures$Expenditures[df_expenditures$Country == "Germany"] <- 6.5
df_expenditures$Expenditures[df_expenditures$Country == "Switzerland"] <- Switzerland
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
df_expenditures$Expenditures[df_expenditures$Country == "New Zealand"] <- NewZeland


df_expenditures$Expenditures[df_expenditures$Country == "Jordan"] <- 3.8
df_expenditures$Expenditures[df_expenditures$Country == "Czech Republic"] <- Czech
df_expenditures$Expenditures[df_expenditures$Country == "Chile"] <- Chile
df_expenditures$Expenditures[df_expenditures$Country == "Japan"] <- Japan
df_expenditures$Expenditures[df_expenditures$Country == "Nigeria"] <- 1.62












# Country = c('Korea','Singapore', 'Japan', 'Chile', 'Czech Republic', 'Nigeria','China', 'Germany', 'Switzerland',
# 'Mexico', 'Jordan', 'Brazil', 'Russia', 'United States', 'United Kingdom', 'United Arab Emirates', 'Australia', 'South
# Africa', 'Kenya','Finland', 'Canada', 'Israel', 'New Zealand')

# http://data.worldbank.org/indicator/SE.PRM.CMPT.ZS http://data.worldbank.org/indicator/SE.SEC.CMPT.LO.ZS
# http://www.uis.unesco.org/Library/Documents/eiguide09-en.pdf

# Korea <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KOR', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Singapore <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SGP', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] China <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHN', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Germany <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__DEU', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Switzerland <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__SWZ', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Mexico <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__MEX', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Brazil <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__BRA', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Russia <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__RUS', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] USA <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__USA', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] UK <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__GBR', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] UAE <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ARE', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Australia <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__AUS', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] SA <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__ZAF', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Kenya <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__KEN', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Finland <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__FIN', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Canada <-
# Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CAN', authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Israel <-
# Quandl('WORLDBANK/ISR_GER_PRI_CMPT_TOT', trim_start='2010-12-31', trim_end='2013-12-31',
# authcode='GgnxpyUBXHsyQxqp67bY')[3,2] NewZeland <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NZL',
# authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Japan <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__JPN',
# authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Czech <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CZE',
# authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Chile <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__CHL',
# authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Nigeria <- Quandl('UN/UIS_PUBLICEXPENDITUREONEDUCATIONASOFGDP__NGA',
# authcode='GgnxpyUBXHsyQxqp67bY')[1,2] Jordan <- Quandl('WORLDBANK/JOR_GER_PRI_CMPT_TOT', trim_start='2010-12-31',
# trim_end='2013-12-31', authcode='GgnxpyUBXHsyQxqp67bY')[3,2] df_dropout <- data.frame(Country = Country, DropoutRate =
# seq(1,23), stringsAsFactors=FALSE) df_dropout$dropout[df_dropout$Country == 'Jordan'] <- Jordan
# df_dropout$dropout[df_dropout$Country == 'Korea'] <- Korea df_dropout$dropout[df_dropout$Country == 'Singapore'] <-
# Singapore #extra df_dropout$dropout[df_dropout$Country == 'China'] <- China df_dropout$dropout[df_dropout$Country ==
# 'Germany'] <- Germany df_dropout$dropout[df_dropout$Country == 'Switzerland'] <- Switzerland
# df_dropout$dropout[df_dropout$Country == 'Mexico'] <- Mexico df_dropout$dropout[df_dropout$Country == 'Brazil'] <- Brazil
# df_dropout$dropout[df_dropout$Country == 'Russia'] <- Russia df_dropout$dropout[df_dropout$Country == 'United States'] <-
# USA df_dropout$dropout[df_dropout$Country == 'United Kingdom'] <- UK df_dropout$dropout[df_dropout$Country == 'United
# Arab Emirates'] <- UAE df_dropout$dropout[df_dropout$Country == 'Australia'] <- Australia
# df_dropout$dropout[df_dropout$Country == 'South Africa'] <- SA df_dropout$dropout[df_dropout$Country == 'Kenya'] <- Kenya
# df_dropout$dropout[df_dropout$Country == 'Finland'] <- Finland df_dropout$dropout[df_dropout$Country == 'Canada'] <-
# Canada df_dropout$dropout[df_dropout$Country == 'Israel'] <- Israel df_dropout$dropout[df_dropout$Country == 'New
# Zealand'] <- NewZeland df_dropout$dropout[df_dropout$Country == 'Jordan'] <- Jordan df_dropout$dropout[df_dropout$Country
# == 'Czech Republic'] <- Czech df_dropout$dropout[df_dropout$Country == 'Chile'] <- Chile
# df_dropout$dropout[df_dropout$Country == 'Japan'] <- Japan df_dropout$dropout[df_dropout$Country == 'Nigeria'] <- Nigeria 
