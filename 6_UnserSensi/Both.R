#' https://beckmw.wordpress.com/2013/10/07/sensitivity-analysis-for-neural-networks/
library(plyr)
library("dplyr")
library("reshape2")
library("ggplot2")
library(splines)
library(MASS)

set.seed(5154)
source("1_RawData/DataFrame.R")
source("2_Imputation/Imputation.R")
source("4_Normalization/Scale.R")
source("3_MultivariateAnalysis/PCAandFA.R")
source("5_WeightingAggregation/WeAg.R")

df.Original.Imputed
df.Zscore.Imputed


df.Original.MM.FA # Min-MAX + FA weights.
df.Original.MM.EW # MIn-MAX + EW
df.Zscore.FA # ZSCORE + FA
df.Zscore.EW # Zscore EW


df.Original.MM.FA$Country <- rownames(df.Original.MM.FA) 
df.Original.MM.EW$Country <- rownames(df.Original.MM.EW) 
df.Zscore.FA$Country <- rownames(df.Zscore.FA) 
df.Zscore.EW$Country <- rownames(df.Zscore.EW) 

zdv <- inner_join(df.Original.MM.FA, df.Original.MM.EW, by= "Country")
zdv2 <- inner_join(df.Zscore.FA, df.Zscore.EW, by= "Country")

zdvBOTH <- inner_join(zdv, zdv2, by= "Country")
zdvBOTH <- subset(zdvBOTH, select=c(Country, RankMM.FA, RankMM.EW, RankZS.FA, RankZS.EW))

what_long <- melt(zdvBOTH, id="Country")  # convert to long format

what_long$Country[what_long$Country == "United States"] <- "USA"
what_long$Country[what_long$Country == "United Arab Emirates"] <- "UAE"
what_long$Country[what_long$Country == "United Kingdom"] <- "UK"

#' http://stackoverflow.com/questions/17150183/r-plot-multiple-lines-in-one-graph
d <- ggplot(data=what_long, aes(x=Country, y=value, colour=variable, group = variable))
d <- d + geom_line() + geom_point(size = 4, shape=21, fill="white")  # geom_ribbon(aes(ymin=value, ymax=value+1))
d <- d + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
d <- d + ggtitle("Comparison of different methods") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
d


what_long3 <- melt(zscoreMultiEqual.Weights, id="Country")  # convert to long format
what_long4 <- melt(zscoreMultiFA.Weights, id="Country")  # convert to long format
what_long5 <- melt(minMaxMultiEqual.Weights, id="Country")  # convert to long format
what_long6 <- melt(minMaxMultiFA.Weights, id="Country")  # convert to long format

# Var1 is country
# Var2 is indicator

e <- ggplot(data=what_long6, aes(Var1, fill=Var2, weight=value))
e <- e + geom_bar() # + facet_wrap(~ Var2)
e 

