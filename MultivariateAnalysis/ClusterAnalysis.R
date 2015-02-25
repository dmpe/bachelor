library(fpc)
library(cluster)
library(NbClust)
library(clustrd)
library(ggplot2)
library(reshape2)


# Use when new data frame is needed
source("RawData/DataFrame.R")
set.seed(5154)
source("Imputation/MICE_Imputation.R")


# Fix for the plot, using agnes; Later; moved to MICE
# https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
# joinedDB.6 <- data.frame(joinedDB.6[,-1], row.names=joinedDB.6[,1])

# How many clusters ? My choice of 2
# nc <- NbClust(joinedDB.6, distance = "euclidean", method="single", index="all")
nc <- NbClust(joinedDB.6, distance = "euclidean", method="ward.D2", index="all")
# nc <- NbClust(scale(joinedDB.6), distance = "euclidean", method="kmeans", index="all")
# NbClust(joinedDB.6, distance = "euclidean", method="ward.D", index="all")

barplot(table(nc$Best.n[1,]), xlab="Numer of Clusters", ylab="Number of Criteria", main="Number of Clusters according to 23 Criteria")

# library(flexclust)
# http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/
# Not possible in my case, because of non-existent type (e.g. default data would need have already some kind of Type/"Cluster" which we could then compare with the new cluster "quantify the agreement between type and cluster")
# fit.km <- kmeans(scale(joinedDB.6), 2, nstart=25)
# fit.km
# ct.km <- table(joinedDB.5$Country, fit.km$cluster)
# ct.km
# randIndex(ct.km)


# http://www.statmethods.net/advstats/cluster.html
# dfa <- scale(joinedDB.6)
# pamk(dfa)
# wss <- (nrow(dfa)-1)*sum(apply(dfa,2,var))
# for (i in 2:15) {
#   wss[i] <- sum(kmeans(dfa,centers=i)$withinss)
# }
# plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares") 


# produces same results, just different package. 
# https://stackoverflow.com/questions/18817476/how-to-generate-a-labelled-dendogram-using-agnes
agn <- agnes(x=dist(joinedDB.6), diss = TRUE, method = "ward", metric ="euclidean")
plot(agn)
plot(as.dendrogram(agn, hang = -1)) 


# Hierarchical Clustering
# http://rpubs.com/gaston/dendrograms
euroclust <- hclust(dist(joinedDB.6, method="euclidean"), "ward.D2")
plot(euroclust, hang = -1)
rect.hclust(euroclust, k=2, border="red") # create border for 2 clusters
# groupsTree <- cutree(euroclust, k=2)


# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
# K Means
klust <- kmeans(dist(joinedDB.6, method = "euclidean"), 2, nstart=25, iter.max=100)
# aggregate(joinedDB.6, by=list(klust$cluster), FUN=mean) # get cluster means
mydata <- data.frame(joinedDB.6, klust$cluster) # append cluster assignment

# Some clusters par. around mean
# clusplot(pam(joinedDB.6,2, metric = "euclidean", stand = TRUE))
clusplot(pam(dist(joinedDB.6, method = "euclidean"), 2), color=TRUE, shade=TRUE, labels=2)


# https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis
# Solhouette plot
sk2 <- silhouette(klust$cl, dist(joinedDB.6, method = "euclidean"))
plot(sk2)


# Who is in, who is out ?
sort(table(klust$clust))
clust <- names(sort(table(klust$clust)))
clust
row.names(mydata[klust$clust==clust[1],])
row.names(mydata[klust$clust==clust[2],])

Developing <- sapply(mydata[klust$clust==clust[1],], mean)
Advanced <- sapply(mydata[klust$clust==clust[2],], mean)
dfClustMeans <- data.frame(Developing, Advanced)
dfClustMeans <- dfClustMeans[1:6,]
dfClustMeans$vars <- rownames(dfClustMeans)
dfClustMeans
sapply(dfClustMeans, class)

test_data_long <- melt(dfClustMeans)  # convert to long format

# http://www.cookbook-r.com/Graphs/Shapes_and_line_types/
# http://www.cookbook-r.com/Graphs/Legends_%28ggplot2%29/
ggplot(test_data_long, aes(x=vars, y=value, group = variable, color = variable)) +
  geom_line() + geom_point() + coord_cartesian(ylim=c(-1.2, 1)) + scale_y_continuous(breaks=seq(-1.2, 1, 0.25)) + theme_gdocs() + ggtitle("Means plot for clusters") + scale_color_gdocs() + ylab("Mean") + xlab("Indicator") 



