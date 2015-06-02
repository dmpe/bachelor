library(cluster)
library(NbClust)
library(ggplot2)
library(clustrd)
library(reshape2)
library(gridExtra)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
# source("3_Normalization/Scale.R")

################################
#' library(fpc)
#' library(vegan)
#' library(pvclust)
#' library(flexclust)
#' library(ggthemes)
#'
#' http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/ 
#' https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
#' http://www.statmethods.net/advstats/cluster.html 
#' http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
#' https://stats.stackexchange.com/questions/7860/visualizing-a-million-pca-edition?lq=1
#' https://stackoverflow.com/questions/18817476/how-to-generate-a-labelled-dendogram-using-agnes
#' http://rpubs.com/gaston/dendrograms
#' https://stats.stackexchange.com/questions/109949/what-algorithm-does-ward-d-in-hclust-implement-if-it-is-not-wards-criteria
#' http://www.r-bloggers.com/setting-graph-margins-in-r-using-the-par-function-and-lots-of-cow-milk/
#' https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis
#' https://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters?rq=1
#' http://www.cookbook-r.com/Graphs/Shapes_and_line_types/ 
#' http://www.cookbook-r.com/Graphs/Legends_%28ggplot2%29/
#' http://blog.mollietaylor.com/2013/10/table-as-image-in-r.html
################################

#' Fix for the plot, using agnes; Later moved to MICE; df.Original.MinMax
#' df.Zscore.Imputed <- data.frame(df.Zscore.Imputed[,-1], row.names=df.Zscore.Imputed[,1])

#' How many clusters ?
nc <- NbClust(df.Original.MinMax, distance = "euclidean", method = "ward.D2", index = "all")
barplot(table(nc$Best.n[1, ]), xlab = "Numer of Clusters", ylab = "Number of Criteria",
        main = "Number of Clusters according to 23 Criteria")


# dfa <- scale(df.Original.MinMax) 
# pamk(df.Original.MinMax) 
# wss <- (nrow(df.Original.MinMax)-1)*sum(apply(df.Original.MinMax,2,var)) 
# for (i in 2:15) { 
#   wss[i] <- sum(kmeans(df.Original.MinMax,centers=i)$withinss) 
# } 
# plot(1:15, wss, type='b', xlab='Number of Clusters', ylab='Within groups sum of squares')


#' produces same results, just different technique
agn <- agnes(x = dist(df.Original.MinMax), method = "ward", metric = "euclidean")
plot(agn) 
#' plot(as.dendrogram(agn, hang = -1))


#' Hierarchical Clustering 
euroclust <- hclust(dist(df.Original.MinMax, method = "euclidean"), "ward.D2")
plot(euroclust, hang = -1)
rect.hclust(euroclust, k = 2, border = "red")  # create border for 2 clusters
coef.hclust(euroclust) # agglomerative coef.

#' Pseudo K-Means - first create wrong clustering and then replace it with the correct one 
klust <- kmeans(dist(df.Original.MinMax, method = "euclidean"), 2, nstart = 25, iter.max = 100)
dataWithCluster <- data.frame(df.Original.MinMax, klust$cluster)  # append cluster assignment df.Original.MinMax

# now apply the fix -> will become 19 vs. 11
dataWithCluster$klust.cluster[rownames(dataWithCluster) == "Chile"] <- 2
dataWithCluster$klust.cluster[rownames(dataWithCluster) == "Hungary"] <- 2
dataWithCluster$klust.cluster[rownames(dataWithCluster) == "Russia"] <- 2
dataWithCluster$klust.cluster[rownames(dataWithCluster) == "United Arab Emirates"] <- 2

#' Who is in, who is out ?  
#' 1 advanced
#' 2 devel
row.names(dataWithCluster[dataWithCluster$klust.cluster=="1",]) 
row.names(dataWithCluster[dataWithCluster$klust.cluster=="2",])

################
# [!rownames(df.Original.MinMax) == "United Arab Emirates", ] # To be used when UAE should not be included. Need to be in both rows above
################

#' Silhouette plot 
# sk2 <- silhouette(klust$cl, dist(df.Zscore.Imputed, method = 'euclidean')) 
# plot(sk2)
# par(mar = c(5, 10, 3, 2) + 0.1)
# sk3 <- silhouette(pam(df.Zscore.Imputed, 2))
# plot(sk3, max.strlen = 30)
#' K-menas clusters; should be with 'dist'
#' clusplot(pam(dist(df.Zscore.Imputed), 2), color = TRUE, shade = TRUE, labels = 2)

Developing <- sapply(dataWithCluster[dataWithCluster$klust.cluster == "1", ], mean)
Advanced <- sapply(dataWithCluster[dataWithCluster$klust.cluster == "2", ], mean)

aggregate(df.Original.MinMax, by=list(dataWithCluster$klust.cluster), FUN = mean) # gets cluster mean

dfClustMeans <- data.frame(Developing, Advanced)
dfClustMeans <- dfClustMeans[1:6, ]
dfClustMeans$vars <- rownames(dfClustMeans)
dfClustMeans$vars[dfClustMeans$vars == "Unemployment_NonScaled"] <- "Y. Unemployment"
dfClustMeans$vars[dfClustMeans$vars == "Freedom_Index_NonScaled"] <- "Freedom Index"
dfClustMeans$vars[dfClustMeans$vars == "WEF_Score_NonScaled"] <- "WEF's GCI"
dfClustMeans$vars[dfClustMeans$vars == "LearningCurve_Index"] <- "Learning Curve Index"
dfClustMeans$vars[dfClustMeans$vars == "HDIEducatIndex"] <- "HDI's Edu. Index"
dfClustMeans$vars[dfClustMeans$vars == "H_Index_NonScaled"] <- "H-Index"

# sapply(dfClustMeans, class)

dataWithCluster.long <- melt(dfClustMeans)  # convert to long format

# table for the picture
dataWithCluster.table <- data.frame(cbind(Indicator = dfClustMeans$vars, Difference = round(dfClustMeans$Advanced-dfClustMeans$Developing,1)))
dataWithCluster.table$Indicator <- as.character(dataWithCluster.table$Indicator)
dataWithCluster.table$Difference <- as.numeric(levels(dataWithCluster.table$Difference))[dataWithCluster.table$Difference]
dataWithCluster.table <- dataWithCluster.table[with(dataWithCluster.table, order(Difference)), ]
row.names(dataWithCluster.table) <- NULL

gp <- ggplot(dataWithCluster.long, aes(x = vars, y = value, group = variable, color = variable)) 
gp <- gp + geom_line() + geom_point() + ggtitle("Means plot for clusters")
gp <- gp + coord_cartesian(ylim = c(10, 105)) + scale_y_continuous(breaks = seq(10, 105, 5))
gp <- gp + ylab("Mean of each varaible in 2 clusters") + xlab("Indicators") + labs(color = "Types of Countries")
gp <- gp + annotation_custom(grob = tableGrob(as.matrix(dataWithCluster.table), gpar.coltext = gpar(cex = 1.2), 
                                              gpar.rowtext = gpar(cex = 1.2)), xmin = 0, xmax = 11, ymin = 0, ymax = 48)
gp

###############  0.5 mentioned in the text, page 44
mean(df.Original.Imputed[c("Australia", "Canada", "Chile", "Czech Republic", "Finland", "Germany", "Israel", "Japan", "Korea", 
                           "New Zealand", "Singapore", "Switzerland", "United Kingdom", "United States", "China", "Russia", "Hungary",
                           "France"), 4])


################ To continue, look in 'Normalisation' folder, ->> 'Scale.R' is required to run   "United Arab Emirates",
# 
# cluster.bootstrap <- pvclust(df.Zscore.Imputed, nboot = 1000, method.dist = "correlation", method.hclust = "ward.D2")
# plot(cluster.bootstrap)
# pvrect(cluster.bootstrap) 

# pamk.best <- pamk(df.Zscore.Imputed)
# cat("number of clusters estimated by optimum average silhouette width:", pamk.best$nc, "\n")
# plot(pam(df.Zscore.Imputed, pamk.best$nc))

# fitcas <- cascadeKM(df.Zscore.Imputed, 1, 10, iter = 1000)
# plot(fitcas, sortg = TRUE, grpmts.plot = TRUE)
# calinski.best <- as.numeric(which.max(fitcas$results[2,]))
# cat("Calinski criterion optimal number of clusters:", calinski.best, "\n")


