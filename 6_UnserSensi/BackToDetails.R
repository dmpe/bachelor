library(reshape2)
library(ggplot2)

set.seed(5154)
source("1_RawData/DataFrame.R")
source("2_Imputation/Imputation.R")
source("3_Normalization/Scale.R")
source("4_MultivariateAnalysis/PCAandFA.R")
source("5_WeightingAggregation/WeAg.R")
source("6_UnserSensi/US_Graphs.R")

#######################
# library(grid)
# library(gridExtra)
# minMaxMultiFA.Weights
# minMaxMultiMyChoice.Weights
#######################

df.BackToDetails <- as.data.frame(minMaxMultiFA.Weights)
df.BackToDetails$Country <- rownames(df.BackToDetails) 
df.BackToDetails.p1 <- df.BackToDetails[, 1:3]
df.BackToDetails.p1$Country <- rownames(df.BackToDetails.p1) 
df.BackToDetails.p2 <- df.BackToDetails[, 4:7]

# Sum rowwise
df.BackToDetails.p2 <- adply(df.BackToDetails.p2, 1, transform, sumEdu = sum(LearningCurve_Index, HDIEducatIndex, H_Index_NonScaled))
df.BackToDetails.p1 <- adply(df.BackToDetails.p1, 1, transform, sumBuEco = sum(Unemployment_NonScaled, WEF_Score_NonScaled, Freedom_Index_NonScaled))


df.BackToDetails <- data.frame(Education = df.BackToDetails.p2$sumEdu, 
                               BussEcon = df.BackToDetails.p1$sumBuEco, 
                               Country = df.BackToDetails.p1$Country)

df.BackToDetails$Country <- as.character(df.BackToDetails$Country)

df.BackToDetails$Country[df.BackToDetails$Country == "United States"] <- "USA"
df.BackToDetails$Country[df.BackToDetails$Country == "United Arab Emirates"] <- "UAE"
df.BackToDetails$Country[df.BackToDetails$Country == "United Kingdom"] <- "UK"
df.BackToDetails$Country[df.BackToDetails$Country == "Czech Republic"] <- "Czech Rep."
df.BackToDetails$Country[df.BackToDetails$Country == "South Africa"] <- "S. Africa"
df.BackToDetails$Country[df.BackToDetails$Country == "New Zealand"] <- "N. Zealand"
# df.BackToDetails$Country[df.BackToDetails$Country == "Switzerland"] <- "Swizerl."

df.meltedBackToDetails <- melt(df.BackToDetails, id = "Country")  # convert to long format

e9 <- ggplot(data = df.meltedBackToDetails, aes(reorder(Country, value), fill = variable, weight = value)) + geom_bar()
e9 <- e9 + coord_cartesian(ylim = c(0, 100)) + scale_y_continuous(breaks = seq(0, 100, 5))
e9 <- e9 + ggtitle("Bar chart decomposition of the Attractiveness Index (MM.FA)") + scale_fill_discrete(name = "Dimensions")
e9 <- e9 + ylab("Index Value") + xlab("Countries")
e9

# Table
EducatValue <- cbind(df.BackToDetails$Education / (df.BackToDetails$Education + df.BackToDetails$BussEcon))
BusinessValue <- cbind(df.BackToDetails$BussEcon / (df.BackToDetails$Education + df.BackToDetails$BussEcon))

df.BackToDetails.table <- data.frame(cbind(df.BackToDetails$Country), EducatValue, BusinessValue)
df.BackToDetails.table

# This is only for Equal Weighting Results

# df.BackToDetails2 <- as.data.frame(minMaxMultiEqual.Weights)
# df.BackToDetails2$Country <- rownames(df.BackToDetails) 
# df.BackToDetails2.p1 <- df.BackToDetails2[, 1:3]
# df.BackToDetails2.p1$Country <- rownames(df.BackToDetails2.p1) 
# df.BackToDetails2.p2 <- df.BackToDetails2[, 4:7]
# 
# # Sum rowwise
# df.BackToDetails2.p2 <- adply(df.BackToDetails2.p2, 1, transform, sumEdu = sum(LearningCurve_Index, HDIEducatIndex, H_Index_NonScaled))
# df.BackToDetails2.p1 <- adply(df.BackToDetails2.p1, 1, transform, sumBuEco = sum(Unemployment_NonScaled, WEF_Score_NonScaled, Freedom_Index_NonScaled))
# 
# 
# df.BackToDetails2 <- data.frame(Education = df.BackToDetails2.p2$sumEdu, 
#                                BussEcon = df.BackToDetails2.p1$sumBuEco, 
#                                Country = df.BackToDetails2.p1$Country)
# 
# df.BackToDetails2$Country <- as.character(df.BackToDetails2$Country)
# 
# df.BackToDetails2$Country[df.BackToDetails2$Country == "United States"] <- "USA"
# df.BackToDetails2$Country[df.BackToDetails2$Country == "United Arab Emirates"] <- "UAE"
# df.BackToDetails2$Country[df.BackToDetails2$Country == "United Kingdom"] <- "UK"
# df.BackToDetails2$Country[df.BackToDetails2$Country == "Czech Republic"] <- "Czech Rep."
# df.BackToDetails2$Country[df.BackToDetails2$Country == "South Africa"] <- "S. Africa"
# df.BackToDetails2$Country[df.BackToDetails2$Country == "New Zealand"] <- "N. Zealand"
# # df.BackToDetails2$Country[df.BackToDetails2$Country == "Switzerland"] <- "Swizerl."
# 
# df.meltedBackToDetails2 <- melt(df.BackToDetails2, id = "Country")  # convert to long format
# 
# e10 <- ggplot(data = df.meltedBackToDetails2, aes(reorder(Country, value), fill = variable, weight = value)) + geom_bar()
# e10 <- e10 + coord_cartesian(ylim = c(0, 100)) + scale_y_continuous(breaks = seq(0, 100, 5))
# e10 <- e10 + ggtitle("Bar chart decomposition of the Attractiveness Index (MM.EW)") + scale_fill_discrete(name = "Dimensions")
# e10 <- e10 + ylab("Index Value") + xlab("Countries")
# e10

