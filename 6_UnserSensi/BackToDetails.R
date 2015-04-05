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
source("6_UnserSensi/US_Graphs.R")


df.BackToDetails <- as.data.frame(minMaxMultiFA.Weights)
df.BackToDetails$Country <- rownames(df.BackToDetails) 
df.BackToDetails.p1 <- df.BackToDetails[,1:3]
df.BackToDetails.p1$Country <- rownames(df.BackToDetails.p1) 
df.BackToDetails.p2 <- df.BackToDetails[,4:7]

# Sum rowwise
df.BackToDetails.p2 <- adply(df.BackToDetails.p2, 1, transform, sumEdu = sum(LearningCurve_Index, CompletionRate_NonScaled, H_Index_NonScaled))
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

what_long9 <- melt(df.BackToDetails, id="Country")  # convert to long format

e9 <- ggplot(data=what_long9, aes(reorder(Country, value), fill=variable, weight=value)) + geom_bar()
e9 <- e9 + coord_cartesian(ylim = c(0, 85)) + scale_y_continuous(breaks = seq(0, 85, 5))
e9 <- e9 + ggtitle("Bar chart decomposition of Attractiveness Index (MM.FA)") + scale_fill_discrete(name="Dimensions")
e9 <- e9 + ylab("Position in Ranking") + xlab("Countries") + labs(color = "Weights") 
e9

# Table
EducatValue <- cbind(df.BackToDetails$Education / (df.BackToDetails$Education + df.BackToDetails$BussEcon))
BusinessValue <- cbind(df.BackToDetails$BussEcon / (df.BackToDetails$Education + df.BackToDetails$BussEcon))

df.BackToDetails.table <- data.frame(cbind(df.BackToDetails$Country), EducatValue, BusinessValue)

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
# multiplot(e1, e2, e3, e4, cols=2)
# par(mfrow=c(2,2))

