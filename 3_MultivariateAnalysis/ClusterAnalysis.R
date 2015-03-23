library(cluster)
library(NbClust)
library(clustrd)
library(ggplot2)
library(pvclust)
library(reshape2)
library("ggthemes")
library(flexclust)
library(fpc)
library(vegan)

# Use when new data frame is needed
set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/MICE_Imputation.R")

#' Fix for the plot, using agnes; Later; moved to MICE
#' https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
#' joinedDB.6 <- data.frame(joinedDB.6[,-1], row.names=joinedDB.6[,1])

#' How many clusters ? My choice of 2 
#' nc <- NbClust(joinedDB.6, distance = 'euclidean', method='single', index='all') 
#' nc <- NbClust(joinedDB.6, distance = 'euclidean', method='kmeans', index='all') 
#' NbClust(joinedDB.6, distance = 'euclidean', method='ward.D', index='all') ward.D2

nc <- NbClust(joinedDB.6, distance = "euclidean", method = "ward.D2", index = "all")
barplot(table(nc$Best.n[1, ]), xlab = "Numer of Clusters", ylab = "Number of Criteria",
        main = "Number of Clusters according to 23 Criteria")

#' http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/ 
#' Not possible in my case, because of non-existent
#' type (e.g. default data would need have already some kind of Type/'Cluster' which we could then compare with the new
#' cluster 'quantify the agreement between type and cluster')
# fit.km <- kmeans(joinedDB.6, 2, nstart = 25)
# fit.km
# ct.km <- table(joinedDB.5$Country, fit.km$cluster)
# ct.km


#' http://www.statmethods.net/advstats/cluster.html 
# dfa <- scale(joinedDB.6) 
# pamk(joinedDB.6) 
# wss <- (nrow(joinedDB.6)-1)*sum(apply(joinedDB.6,2,var)) 
# for (i in 2:15) { 
#   wss[i] <- sum(kmeans(joinedDB.6,centers=i)$withinss) 
# } 
# plot(1:15, wss, type='b', xlab='Number of Clusters', ylab='Within groups sum of squares')


#' produces same results, just different package
#' https://stackoverflow.com/questions/18817476/how-to-generate-a-labelled-dendogram-using-agnes
agn <- agnes(x = dist(joinedDB.6), method = "ward", metric = "euclidean")
agn
plot(agn) 
#' plot(as.dendrogram(agn, hang = -1))


#' Hierarchical Clustering 
#' http://rpubs.com/gaston/dendrograms
#' https://stats.stackexchange.com/questions/109949/what-algorithm-does-ward-d-in-hclust-implement-if-it-is-not-wards-criteria?rq=1
euroclust <- hclust(dist(joinedDB.6, method = "euclidean"), "ward.D2") # ward.D2 & complete is similar too
plot(euroclust, hang = -1)
rect.hclust(euroclust, k = 2, border = "red")  # create border for 2 clusters
coef.hclust(euroclust)

#' K Means 
#' http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
#' https://stats.stackexchange.com/questions/7860/visualizing-a-million-pca-edition?lq=1
klust <- kmeans(dist(joinedDB.6, method = "euclidean"), 2, nstart = 25, iter.max = 100)
mydata <- data.frame(joinedDB.6, klust$cluster)  # append cluster assignment
# aggregate(joinedDB.6, by=list(klust$cluster), FUN = mean) # get cluster means



#' Silhouette plot 
#' http://www.r-bloggers.com/setting-graph-margins-in-r-using-the-par-function-and-lots-of-cow-milk/
#' https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis
#' that's fucking silly
#' Very good overview of all 8 methods
#' https://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters?rq=1

sk2 <- silhouette(klust$cl, dist(joinedDB.6, method = 'euclidean')) 
plot(sk2)

# par(mar = c(5, 10, 3, 2) + 0.1)
# sk3 <- silhouette(pam(joinedDB.6, 2))
# plot(sk3, max.strlen = 30)
#' K-menas clusters; should be with 'dist'
#' clusplot(pam(dist(joinedDB.6), 2), color = TRUE, shade = TRUE, labels = 2)


#' Who is in, who is out ?  
#' sort(table(klust$clust))
clust <- names(sort(table(klust$clust)))
row.names(mydata[klust$clust==clust[1],]) 
row.names(mydata[klust$clust==clust[2],])

Developing <- sapply(mydata[klust$clust == clust[1], ], mean)
Advanced <- sapply(mydata[klust$clust == clust[2], ], mean) #0.55 mentioned in the text, page 44

dfClustMeans <- data.frame(Developing, Advanced)
dfClustMeans <- dfClustMeans[1:6, ]
dfClustMeans$vars <- rownames(dfClustMeans)
dfClustMeans
#' sapply(dfClustMeans, class)

test_data_long <- melt(dfClustMeans)  # convert to long format

#' http://www.cookbook-r.com/Graphs/Shapes_and_line_types/ 
#' http://www.cookbook-r.com/Graphs/Legends_%28ggplot2%29/
gp <- ggplot(test_data_long, aes(x = vars, y = value, group = variable, color = variable)) 
gp <- gp + geom_line() + geom_point()
gp <- gp + coord_cartesian(ylim = c(-1.2, 1)) + scale_y_continuous(breaks = seq(-1.2, 1, 0.25))
gp <- gp + theme_gdocs() + scale_color_gdocs()
gp <- gp + ylab("Mean") + xlab("Indicators") + labs(color = "Types of Countries") + ggtitle("Means plot for clusters")
gp

# cluster.bootstrap <- pvclust(joinedDB.6, nboot = 1000, method.dist = "correlation", method.hclust = "ward.D2")
# plot(cluster.bootstrap)
# pvrect(cluster.bootstrap) 

# To continue look in 'Normalisation' folder, ->> 'Scale.R' is required to run, while 'SampleIOEFreedom.R' may be recommendet

pamk.best <- pamk(joinedDB.6)
cat("number of clusters estimated by optimum average silhouette width:", pamk.best$nc, "\n")
plot(pam(joinedDB.6, pamk.best$nc))


fitcas <- cascadeKM(joinedDB.6, 1, 10, iter = 1000)
plot(fitcas, sortg = TRUE, grpmts.plot = TRUE)
calinski.best <- as.numeric(which.max(fitcas$results[2,]))
cat("Calinski criterion optimal number of clusters:", calinski.best, "\n")


