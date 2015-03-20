#' https://beckmw.wordpress.com/2013/10/07/sensitivity-analysis-for-neural-networks/

library("dplyr")
library("reshape2")
library("ggplot2")
library(splines)
library(MASS)

set.seed(5154)
source("1_RawData/DataFrame.R")
source("2_Imputation/MICE_Imputation.R")
source("3_MultivariateAnalysis/PCAandFA.R")
source("4_Normalization/Scale.R")
source("5_WeightingAggregation/WeAg.R")

joinedDB.6
joinedDB.7

joinedDB.8 # Min-MAX + FA weights.
joinedDB.9 # MIn-MAX + EW
joinedDB.10 # ZSCORE + FA
joinedDB.11 # Zscore EW


joinedDB.8$Country <- rownames(joinedDB.8) 
joinedDB.9$Country <- rownames(joinedDB.9) 
joinedDB.10$Country <- rownames(joinedDB.10) 
joinedDB.11$Country <- rownames(joinedDB.11) 

zdv <- inner_join(joinedDB.8, joinedDB.9, by= "Country")
zdv2 <- inner_join(joinedDB.10, joinedDB.11, by= "Country")

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
