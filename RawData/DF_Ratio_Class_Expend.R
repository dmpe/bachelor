library(corrplot)
library(stringr)
library(plyr)
library(rvest)
library("Quandl")
library(plyr)
library(dplyr)

Quandl.auth("GgnxpyUBXHsyQxqp67bY")


# Teacher Student Ratio
#  SG, HK, SK and Taiwan  || Malaysia, Japan Tailand, Philipines


Germany <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__DEU", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Russia <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__RUS", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
India <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__IND", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Korea <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__KOR", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Indonesia <- Quandl("UN/UIS_TOTALSECONDARYPUPILTEACHERRATIO__IDN", authcode="GgnxpyUBXHsyQxqp67bY")[1,2]
Singapore <- 13.2
Taiwan <- 18
# without hong kong
# c("Hong-Kong SAR") <- 13.5
# ----------------------------------------------------------
  
ratio.not <- data.frame(c(Germany, Russia, India, Korea, Indonesia, Singapore, Taiwan))
ratio <- plyr::rename(ratio.not, c("c.Germany..Russia..India..Korea..Indonesia..Singapore..Taiwan."="Student-Teacher Ratio"))

df_education.names <- data.frame(c("Germany", "Russia", "India", "Korea", "Indonesia", "Singapore", "Taiwan"))
df_education <- plyr::rename(df_education.names, c("c..Germany....Russia....India....Korea....Indonesia....Singapore..."="Country"))

df_education[,"Student-Teacher Ratio"] <- ratio

# -----------------------------------------------------

classsize = c(35.9,31,38.6,40, 29)


df_education[,"Avarage Class Size"] <- classsize






