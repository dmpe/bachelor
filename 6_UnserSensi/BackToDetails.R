
library("reshape2")
library("ggplot2")
library("grid")
library(gridExtra)

set.seed(5154)
source("1_RawData/DataFrame.R")
source("2_Imputation/Imputation.R")
source("4_Normalization/Scale.R")
source("3_MultivariateAnalysis/PCAandFA.R")
source("5_WeightingAggregation/WeAg.R")
source("6_UnserSensi/BackToDetails.R")

library(dplyr)


testingBacktoDetails <- as.data.frame(minMaxMultiEqual.Weights)
testingBacktoDetails$Country <- rownames(testingBacktoDetails) 
testingBacktoDetails.p1 <- testingBacktoDetails[,1:3]
testingBacktoDetails.p1$Country <- rownames(testingBacktoDetails.p1) 
testingBacktoDetails.p2 <- testingBacktoDetails[,4:7]

# Sum rowwise
testingBacktoDetails.p2 <- adply(testingBacktoDetails.p2, 1, transform, sumEdu = sum(LearningCurve_Index, CompletionRate_NonScaled, H_Index_NonScaled))
testingBacktoDetails.p1 <- adply(testingBacktoDetails.p1, 1, transform, sumBuEco = sum(Unemployment_NonScaled, WEF_Score_NonScaled, Freedom_Index_NonScaled))


df.testingBacktoDetails <- data.frame(Edu = testingBacktoDetails.p2$sumEdu, 
                                      BuEco = testingBacktoDetails.p1$sumBuEco, Country = testingBacktoDetails.p1$Country)
df.testingBacktoDetails$Country <- as.character(df.testingBacktoDetails$Country)

df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "United States"] <- "USA"
df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "United Arab Emirates"] <- "UAE"
df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "United Kingdom"] <- "UK"
df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "Czech Republic"] <- "Czech Rep."
df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "South Africa"] <- "S. Africa"
df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "New Zealand"] <- "N. Zealand"
# df.testingBacktoDetails$Country[df.testingBacktoDetails$Country == "Switzerland"] <- "Swizerl."

what_long9 <- melt(df.testingBacktoDetails, id="Country")  # convert to long format

# what_long3 <- melt(zscoreMultiEqual.Weights, id="Country")  # convert to long format
# what_long4 <- melt(zscoreMultiFA.Weights, id="Country")  # convert to long format
# what_long5 <- melt(minMaxMultiEqual.Weights, id="Country")  # convert to long format
# what_long6 <- melt(minMaxMultiFA.Weights, id="Country")  # convert to long format


# Var1 is country
# Var2 is indicator
# source("http://peterhaschke.com/Code/multiplot.R")
# e1 <- ggplot(data=what_long3, aes(Var1, fill=Var2, weight=value)) + geom_bar()
# e2 <- ggplot(data=what_long4, aes(Var1, fill=Var2, weight=value)) + geom_bar()
# e3 <- ggplot(data=what_long5, aes(Var1, fill=Var2, weight=value)) + geom_bar()
# e4 <- ggplot(data=what_long6, aes(Var1, fill=Var2, weight=value)) + geom_bar()
# grid.arrange(e1, e2,e3,e4, ncol = 2, nrow = 2,  main = "Main title")
# grid.arrange(e1, e2,  main = "Main title")


e9 <- ggplot(data=what_long9, aes(reorder(Country, value), fill=variable, weight=value)) + geom_bar()
e9 <- e9 + ggtitle("Comparison of different weights based on Min-Max norm. method") 
e9 <- e9 + ylab("Position in Ranking") + xlab("Countries") + labs(color = "Weights")
e9
# multiplot(e1, e2, e3, e4, cols=2)
# par(mfrow=c(2,2))

