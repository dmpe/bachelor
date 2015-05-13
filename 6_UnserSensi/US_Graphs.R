library(reshape2)
library(ggplot2)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
# source("3_Normalization/Scale.R")
# source("4_MultivariateAnalysis/PCAandFA.R")
# source("5_WeightingAggregation/WeAg.R")

##################################
#' https://beckmw.wordpress.com/2013/10/07/sensitivity-analysis-for-neural-networks/
#' http://docs.ggplot2.org/current/scale_discrete.html
#' http://stackoverflow.com/questions/3253641/how-to-change-the-order-of-a-discrete-x-scale-in-ggplot
#' http://blog.mckuhn.de/2011/08/ggplot2-determining-order-in-which.html
#' http://stackoverflow.com/questions/21192002/how-to-combine-2-plots-ggplot-into-one-plot
#' http://stackoverflow.com/questions/17150183/r-plot-multiple-lines-in-one-graph
#' library(gridExtra)
#' library(plotflow)
#' library(grid)
#' For printing purposes
#' df.Original.Imputed
#' df.Zscore.Imputed
#' df.Original.MM.FA # Min-MAX + FA weights.
#' df.Original.MM.EW # MIn-MAX + EW
#' df.Zscore.FA # ZSCORE + FA
#' df.Zscore.EW # Zscore EW
##################################

df.Original.MM.FA$Country <- rownames(df.Original.MM.FA) 
df.Original.MM.EW$Country <- rownames(df.Original.MM.EW) 
df.Original.MM.MyChoice$Country <- rownames(df.Original.MM.MyChoice) 

meltingOriginal.MM.FA.Subset <- melt(df.Original.MM.FA[, c("Country", "RankMM.FA")],  id = "Country")
meltingOriginal.MM.EW.Subset <- melt(df.Original.MM.EW[, c("Country", "RankMM.EW")],  id = "Country")
meltingOriginal.MM.MC.Subset <- melt(df.Original.MM.MyChoice[, c("Country", "RankMM.MC")],  id = "Country")

meltingOriginal.MM.FA.Subset$Country[meltingOriginal.MM.FA.Subset$Country == "United States"] <- "USA"
meltingOriginal.MM.FA.Subset$Country[meltingOriginal.MM.FA.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingOriginal.MM.FA.Subset$Country[meltingOriginal.MM.FA.Subset$Country == "United Kingdom"] <- "UK"
meltingOriginal.MM.FA.Subset$Country[meltingOriginal.MM.FA.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingOriginal.MM.FA.Subset$Country[meltingOriginal.MM.FA.Subset$Country == "South Africa"] <- "S. Africa"

meltingOriginal.MM.EW.Subset$Country[meltingOriginal.MM.EW.Subset$Country == "United States"] <- "USA"
meltingOriginal.MM.EW.Subset$Country[meltingOriginal.MM.EW.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingOriginal.MM.EW.Subset$Country[meltingOriginal.MM.EW.Subset$Country == "United Kingdom"] <- "UK"
meltingOriginal.MM.EW.Subset$Country[meltingOriginal.MM.EW.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingOriginal.MM.EW.Subset$Country[meltingOriginal.MM.EW.Subset$Country == "South Africa"] <- "S. Africa"

meltingOriginal.MM.MC.Subset$Country[meltingOriginal.MM.MC.Subset$Country == "United States"] <- "USA"
meltingOriginal.MM.MC.Subset$Country[meltingOriginal.MM.MC.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingOriginal.MM.MC.Subset$Country[meltingOriginal.MM.MC.Subset$Country == "United Kingdom"] <- "UK"
meltingOriginal.MM.MC.Subset$Country[meltingOriginal.MM.MC.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingOriginal.MM.MC.Subset$Country[meltingOriginal.MM.MC.Subset$Country == "South Africa"] <- "S. Africa"


me1 <- ggplot()
# green
me1 <- me1 + geom_line(data=meltingOriginal.MM.FA.Subset, aes(reorder(Country, value), value, colour=variable, group = variable))
me1 <- me1 + geom_point(data=meltingOriginal.MM.FA.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), size = 4, shape=21, fill="white") 
# red
me1 <- me1 + geom_line(data=meltingOriginal.MM.EW.Subset, aes(reorder(Country, value), value, colour=variable, group = variable))
me1 <- me1 + geom_point(data=meltingOriginal.MM.EW.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), size = 4, shape=21, fill="white") 
# blue
me1 <- me1 + geom_line(data=meltingOriginal.MM.MC.Subset, aes(reorder(Country, value), value, colour=variable, group = variable))
me1 <- me1 + geom_point(data=meltingOriginal.MM.MC.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), size = 4, shape=21, fill="white") 
# all together
me1 <- me1 + coord_cartesian(ylim = c(0, 35)) + scale_y_continuous(breaks = seq(0, 35, 1))
me1 <- me1 + ggtitle("Comparison of 3 weighting methods (FA/EW/my choice)") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
me1 

########################
# all lines are different, doens't have a straight one
df.Original.MM.FAEW <- inner_join(df.Original.MM.FA, df.Original.MM.EW, by= "Country")
df.Original.MM.FAEW.Subset <- subset(df.Original.MM.FAEW, select=c(Country, RankMM.FA, RankMM.EW))

df.Original.MM.FAEWMC <- inner_join(df.Original.MM.FAEW, df.Original.MM.MyChoice, by= "Country")
df.Original.MM.FAEWMC.Subset <- subset(df.Original.MM.FAEWMC, select=c(Country, RankMM.FA, RankMM.EW, RankMM.MC))

# Now melt them all
meltingOriginal.MM.FAEW.Subset <- melt(df.Original.MM.FAEW.Subset, id="Country") 
meltingOriginal.MM.FAEWMC.Subset <- melt(df.Original.MM.FAEWMC.Subset, id = "Country")

meltingOriginal.MM.FAEWMC.Subset$Country[meltingOriginal.MM.FAEWMC.Subset$Country == "United States"] <- "USA"
meltingOriginal.MM.FAEWMC.Subset$Country[meltingOriginal.MM.FAEWMC.Subset$Country == "United Arab Emirates"] <- "UAE"
meltingOriginal.MM.FAEWMC.Subset$Country[meltingOriginal.MM.FAEWMC.Subset$Country == "United Kingdom"] <- "UK"
meltingOriginal.MM.FAEWMC.Subset$Country[meltingOriginal.MM.FAEWMC.Subset$Country == "Czech Republic"] <- "Czech Rep."
meltingOriginal.MM.FAEWMC.Subset$Country[meltingOriginal.MM.FAEWMC.Subset$Country == "South Africa"] <- "S. Africa"

me3 <- ggplot(data=meltingOriginal.MM.FAEWMC.Subset, aes(reorder(Country, value), value, colour = variable, group = variable))
me3 <- me3 + geom_line() + geom_point(size = 4, shape=21, fill="white")
me3 <- me3 + coord_cartesian(ylim = c(0, 30)) + scale_y_continuous(breaks = seq(0, 30, 1))
me3 <- me3 + ggtitle("Comparison of different weights based on Min-Max norm. method") 
me3 <- me3 + ylab("Position in Ranking") + xlab("Countries") + labs(color = "Weights")
me3

##################

me2 <- ggplot()
me2 <- me2 + geom_line(data=meltingOriginal.MM.FA.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), colour="green")
me2 <- me2 + geom_point(data=meltingOriginal.MM.FA.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), size = 3, shape=21, fill="white")
me2 <- me2 + geom_boxplot(data=meltingOriginal.MM.FAEWMC.Subset, aes(reorder(Country, value), value))
me2 <- me2 + coord_cartesian(ylim = c(0, 35)) + scale_y_continuous(breaks = seq(0, 35, 1))# + scale_colour_manual(values=c("green - FA weights"))
me2 <- me2 + ylab("Position in Ranking") + xlab("Countries") + ggtitle("Box Plot of 3 weighting methods")
me2

###################

p <- ggplot(meltingOriginal.MM.FAEWMC.Subset, aes(reorder(Country, value), value))
p <- p + geom_boxplot() + coord_cartesian(ylim = c(0, 35)) + scale_y_continuous(breaks = seq(0, 35, 1))
p <- p + geom_line(data=meltingOriginal.MM.FA.Subset, aes(reorder(Country, value), value, colour=variable, group = variable), colour="green")
p <- p + ylab("Position in Ranking") + xlab("Countries") + ggtitle("Box Plot of given 3 weighting methods")
p


###################
#' The only disadvantage is that it stores them in a list :(
df.list <- list(x = meltingOriginal.MM.FA.Subset, y = meltingOriginal.MM.EW.Subset, z = meltingOriginal.MM.MC.Subset)
for(i in 1:length(df.list)) {
  df.list[[i]]$Country[df.list[[i]]$Country == "United States"] <- "USA"
  df.list[[i]]$Country[df.list[[i]]$Country == "United Arab Emirates"] <- "UAE"
  df.list[[i]]$Country[df.list[[i]]$Country == "United Kingdom"] <- "UK"
  df.list[[i]]$Country[df.list[[i]]$Country == "Czech Republic"] <- "Czech Rep."
  df.list[[i]]$Country[df.list[[i]]$Country == "South Africa"] <- "S. Africa"
}

######################################################

qwer1 <- melt(df.Original.MM.FA[, c("Country", "Value")],  id = "Country")
qwer1$variable <- as.character(qwer1$variable)
qwer2 <- melt(df.Original.MM.EW[, c("Country", "Value")],  id = "Country")
qwer2$variable <- as.character(qwer2$variable)
qwer3 <- melt(df.Original.MM.MyChoice[, c("Country", "Value")],  id = "Country")
qwer3$variable <- as.character(qwer3$variable)

sapply(qwer1, class)

qwer1$variable[qwer1$variable == "Value"] <- as.character("RankMM.FA")
qwer2$variable[qwer2$variable == "Value"] <- "RankMM.EW"
qwer3$variable[qwer3$variable == "Value"] <- "RankMM.MC"

qwer1$Country[qwer1$Country == "United States"] <- "USA"
qwer1$Country[qwer1$Country == "United Arab Emirates"] <- "UAE"
qwer1$Country[qwer1$Country == "United Kingdom"] <- "UK"
qwer1$Country[qwer1$Country == "Czech Republic"] <- "Czech Rep."
qwer1$Country[qwer1$Country == "South Africa"] <- "S. Africa"

qwer2$Country[qwer2$Country == "United States"] <- "USA"
qwer2$Country[qwer2$Country == "United Arab Emirates"] <- "UAE"
qwer2$Country[qwer2$Country == "United Kingdom"] <- "UK"
qwer2$Country[qwer2$Country == "Czech Republic"] <- "Czech Rep."
qwer2$Country[qwer2$Country == "South Africa"] <- "S. Africa"

qwer3$Country[qwer3$Country == "United States"] <- "USA"
qwer3$Country[qwer3$Country == "United Arab Emirates"] <- "UAE"
qwer3$Country[qwer3$Country == "United Kingdom"] <- "UK"
qwer3$Country[qwer3$Country == "Czech Republic"] <- "Czech Rep."
qwer3$Country[qwer3$Country == "South Africa"] <- "S. Africa"


tyr2 <- ggplot()
tyr2 <- tyr2 + geom_line(data=qwer1, aes(reorder(Country, value), value, group = variable, colour=variable))
tyr2 <- tyr2 + geom_point(data=qwer1, aes(reorder(Country, value), value, group = variable, colour=variable), size = 2, shape=21, fill="white") 
tyr2 <- tyr2 + geom_line(data=qwer2, aes(reorder(Country, value), value, group = variable, colour=variable))
tyr2 <- tyr2 + geom_point(data=qwer2, aes(reorder(Country, value), value, group = variable, colour=variable), size = 2, shape=21, fill="white") 
tyr2 <- tyr2 + geom_line(data=qwer3, aes(reorder(Country, value), value, group = variable, colour=variable))
tyr2 <- tyr2 + geom_point(data=qwer3, aes(reorder(Country, value), value, group = variable, colour=variable), size = 2, shape=21, fill="white") 
tyr2 <- tyr2 + coord_cartesian(ylim = c(35, 85)) + scale_y_continuous(breaks = seq(30, 85, 2))
tyr2 <- tyr2 + ggtitle("Comparison of 3 weighting methods (FA/EW/my choice)") + ylab("Attractiveness Index") + xlab("Countries")
tyr2 




########################################

# meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United States"] <- "USA"
# meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United Arab Emirates"] <- "UAE"
# meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "United Kingdom"] <- "UK"
# meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "Czech Republic"] <- "Czech Rep."
# meltingOriginal.MM.FAEW.Subset$Country[meltingOriginal.MM.FAEW.Subset$Country == "South Africa"] <- "S. Africa"

# df.Zscore.FA$Country <- rownames(df.Zscore.FA) 
# df.Zscore.EW$Country <- rownames(df.Zscore.EW)
# 
# df.Zscore.FAEW <- inner_join(df.Zscore.FA, df.Zscore.EW, by= "Country")
# df.Zscore.FAEW.Subset <- subset(df.Zscore.FAEW, select=c(Country, RankZS.FA, RankZS.EW))

# zdvBOTH <- inner_join(df.Original.MM.FAEW, df.Zscore.FAEW, by= "Country")
# zdvBOTH <- subset(zdvBOTH, select=c(Country, RankMM.FA, RankMM.EW, RankZS.FA, RankZS.EW))

# what_long <- melt(zdvBOTH, id="Country")  # convert to long format
# what_long$Country[what_long$Country == "United States"] <- "USA"
# what_long$Country[what_long$Country == "United Arab Emirates"] <- "UAE"
# what_long$Country[what_long$Country == "United Kingdom"] <- "UK"
# what_long$Country[what_long$Country == "Czech Republic"] <- "Czech Rep."
# what_long$Country[what_long$Country == "South Africa"] <- "S. Africa"
# meltingZscore.FAEW.Subset <- melt(df.Zscore.FAEW.Subset, id="Country")  

# meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United States"] <- "USA"
# meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United Arab Emirates"] <- "UAE"
# meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "United Kingdom"] <- "UK"
# meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "Czech Republic"] <- "Czech Rep."
# meltingZscore.FAEW.Subset$Country[meltingZscore.FAEW.Subset$Country == "South Africa"] <- "S. Africa"


# d <- ggplot(data=what_long, aes(x=Country, y=value, colour=variable, group = variable))
# d <- d + geom_line() + geom_point(size = 4, shape=21, fill="white")  # geom_ribbon(aes(ymin=value, ymax=value+1))
# d <- d + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
# d <- d + ggtitle("Comparison of different methods") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
# d

# me2 <- ggplot(data=meltingZscore.FAEW.Subset, aes(Country, value, colour=variable, group = variable))
# me2 <- me2 + geom_line() + geom_point(size = 4, shape=21, fill="white")  
# me2 <- me2 + coord_cartesian(ylim = c(0, 25)) + scale_y_continuous(breaks = seq(0, 25, 1))
# me2 <- me2 + ggtitle("Comparison of Zscore method with weights based on FA/EW/Self") + ylab("Position in Ranking") + xlab("Countries") + labs(color = "We/No methods")
# me2





