#' https://beckmw.wordpress.com/2013/10/07/sensitivity-analysis-for-neural-networks/
#' http://docs.ggplot2.org/current/scale_discrete.html
#' http://stackoverflow.com/questions/3253641/how-to-change-the-order-of-a-discrete-x-scale-in-ggplot

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

#' For printing purposes
# df.Original.Imputed
# df.Zscore.Imputed
# df.Original.MM.FA # Min-MAX + FA weights.
# df.Original.MM.EW # MIn-MAX + EW
# df.Zscore.FA # ZSCORE + FA
# df.Zscore.EW # Zscore EW

df.Original.MM.FA$Country <- rownames(df.Original.MM.FA) 
df.Original.MM.EW$Country <- rownames(df.Original.MM.EW) 
df.Zscore.FA$Country <- rownames(df.Zscore.FA) 
df.Zscore.EW$Country <- rownames(df.Zscore.EW) 

df.Original.MM.FAEW <- inner_join(df.Original.MM.FA, df.Original.MM.EW, by= "Country")
df.Original.MM.FAEW.Subset <- subset(df.Original.MM.FAEW, select=c(Country, RankMM.FA, RankMM.EW))

df.Zscore.FAEW <- inner_join(df.Zscore.FA, df.Zscore.EW, by= "Country")
df.Zscore.FAEW.Subset <- subset(df.Zscore.FAEW, select=c(Country, RankZS.FA, RankZS.EW))

zdvBOTH <- inner_join(df.Original.MM.FAEW, df.Zscore.FAEW, by= "Country")
zdvBOTH <- subset(zdvBOTH, select=c(Country, RankMM.FA, RankMM.EW, RankZS.FA, RankZS.EW))

what_long <- melt(zdvBOTH, id="Country")  # convert to long format
what_long$Country[what_long$Country == "United States"] <- "USA"
what_long$Country[what_long$Country == "United Arab Emirates"] <- "UAE"
what_long$Country[what_long$Country == "United Kingdom"] <- "UK"
what_long$Country[what_long$Country == "Czech Republic"] <- "Czech Rep."
what_long$Country[what_long$Country == "South Africa"] <- "S. Africa"

#' http://stackoverflow.com/questions/17150183/r-plot-multiple-lines-in-one-graph
d <- ggplot(data=what_long, aes(x=Country, y=value, colour=variable, group = variable))
d <- d + geom_line() + geom_point(size = 4, shape=21, fill="white")  # geom_ribbon(aes(ymin=value, ymax=value+1))
d <- d + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
d <- d + ggtitle("Comparison of different methods") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
d


meltingOriginal.MM.FAEW.Subset <- melt(df.Original.MM.FAEW.Subset, id="Country")  # convert to long format
meltingZscore.FAEW.Subset <- melt(df.Zscore.FAEW.Subset, id="Country")  # convert to long format

meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United States"] <- "USA"
meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United Kingdom"] <- "UK"
meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "South Africa"] <- "S. Africa"


meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United States"] <- "USA"
meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United Kingdom"] <- "UK"
meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "South Africa"] <- "S. Africa"



me1 <- ggplot(data=meltingOriginal.MM.FAEW.Subset, aes(Country, value, colour=variable, group = variable))
me1 <- me1 + geom_line() + geom_point(size = 4, shape=21, fill="white") 
me1 <- me1 + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
me1 <- me1 + ggtitle("Comparison of Min-Max method with weights based on FA/EW/Self") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
me1

me2 <- ggplot(data=meltingZscore.FAEW.Subset, aes(Country, value, colour=variable, group = variable))
me2 <- me2 + geom_line() + geom_point(size = 4, shape=21, fill="white")  
me2 <- me2 + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
me2 <- me2 + ggtitle("Comparison of Zscore method with weights based on FA/EW/Self") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
me2


me3 <- ggplot(data=meltingZscore.FAEW.Subset, aes(reorder(Country, value), value, colour=variable, group = variable))
me3 <- me3 + geom_line() + geom_point(size = 4, shape=21, fill="white")
me3 <- me3 + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
me3 <- me3 + ggtitle("Comparison of Zscore method with weights based on FA/EW/Self") 
me3 <- me3 + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
me3






what_long3 <- melt(zscoreMultiEqual.Weights, id="Country")  # convert to long format
what_long4 <- melt(zscoreMultiFA.Weights, id="Country")  # convert to long format
what_long5 <- melt(minMaxMultiEqual.Weights, id="Country")  # convert to long format
what_long6 <- melt(minMaxMultiFA.Weights, id="Country")  # convert to long format


# Var1 is country
# Var2 is indicator
# source("http://peterhaschke.com/Code/multiplot.R")
e1 <- ggplot(data=what_long3, aes(Var1, fill=Var2, weight=value)) + geom_bar()
e2 <- ggplot(data=what_long4, aes(Var1, fill=Var2, weight=value)) + geom_bar()
e3 <- ggplot(data=what_long5, aes(Var1, fill=Var2, weight=value)) + geom_bar()
e4 <- ggplot(data=what_long6, aes(Var1, fill=Var2, weight=value)) + geom_bar()
grid.arrange(e1, e2,e3,e4, ncol = 2, nrow = 2,  main = "Main title")

# multiplot(e1, e2, e3, e4, cols=2)
# par(mfrow=c(2,2))

