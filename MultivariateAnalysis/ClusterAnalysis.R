library(fpc)
library(mclust)
library(cluster)
library(clustrd)
library(NbClust)
library(flexclust)

# Use when required complete
# source("RawData/DataFrame.R")
# source("Imputation/MICE_Imputation.R")
set.seed(5154)
# Fix for the plot, using agnes; Later
# https://stackoverflow.com/questions/5555408/convert-the-values-in-a-column-into-row-names-in-an-existing-data-frame-in-r
joinedDB.6 <- data.frame(joinedDB.6[,-1], row.names=joinedDB.6[,1])

# How many clusters ? My choice of 2
# NbClust(joinedDB.6, distance = "euclidean", method="single", index="all")
# NbClust(joinedDB.6, distance = "manhattan", method="ward.D2", index="all")
nc <- NbClust(scale(joinedDB.6), distance = "euclidean", method="kmeans", index="all")
# NbClust(joinedDB.6, distance = "euclidean", method="ward.D", index="all")

barplot(table(nc$Best.n[1,]),
        xlab="Numer of Clusters", ylab="Number of Criteria",
        main="Number of Clusters according to 23 Criteria (sum)")

# http://www.r-statistics.com/2013/08/k-means-clustering-from-r-in-action/
# Not Possible in my case, because of non-existent type (e.g. default data set would need have already some kind of Type/"Cluster" which we could then compare for the "quantify the agreement between type and cluster")
# fit.km <- kmeans(scale(joinedDB.6), 2, nstart=25)
# fit.km
# ct.km <- table(joinedDB.5$Country, fit.km$cluster)
# ct.km
# randIndex(ct.km)

# K mean clustering
# joinedDB.6$Country <- as.character(joinedDB.6$Country)

# http://www.statmethods.net/advstats/cluster.html
dfa <- scale(joinedDB.6[2:7])
pamk(dfa)
wss <- (nrow(dfa)-1)*sum(apply(dfa,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(dfa,centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares") 


klust <- kmeans(joinedDB.6[2:7], 4) # 5 cluster solution
klust$cluster
# get cluster means
aggregate(dfa,by=list(klust$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(dfa, klust$cluster) 

# Centroid Plot against 1st 2 discriminant functions
plotcluster(joinedDB.6[2:7], klust$centers, clnum=1) 

# Hierrarchy
clusplot(pam(joinedDB.6[2:7],3, metric = "euclidean", stand = TRUE))

# https://stackoverflow.com/questions/18817476/how-to-generate-a-labelled-dendogram-using-agnes
agn <- agnes(x=joinedDB.6, diss = FALSE, stand = TRUE, method = "single", metric ="euclidean")
plot(agn)
plot(as.dendrogram(agn, hang = -1)) 



# Hierarchical Clustering
euroclust<-hclust(dist(joinedDB.6), "single")
plot(euroclust,hang = -1, labels=joinedDB.6$Country)
groups <- cutree(euroclust, k=3)
rect.hclust(euroclust, k=3, border="red") 


# https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis
km    <- kmeans(joinedDB.6[2:7],2)
dissE <- daisy(joinedDB.6[2:7]) 
dE2   <- dissE^2
sk2   <- silhouette(km$cl, dE2)
plot(sk2)

# Model Based
fit <- Mclust(joinedDB.6[2:7], modelNames=c("VEV"))
fit$bic
plot(fit) # plot results
summary(fit) # display the best model 


# "A method that combines k-means cluster analysis with
# aspects of Factor Analysis and PCA is offered by Vichi & Kiers (2001)" [p. 81].
outf <- FactorialKM(joinedDB.6[2:7], nclus = 3, ndim = 2, nstart=1, smartStart=TRUE)
# outr <- ReducedKM(joinedDB.6[2:7], nclus = 3, 2, nstart=1, smartStart=TRUE)
plotrd(outf,what=c("all","none"),obslabel=rownames(joinedDB.6), density=TRUE)


km.boot <- clusterboot(joinedDB.6[2:7], B=20, bootmethod="boot",
                       clustermethod=kmeansCBI,
                       krange=3, seed=15555)
plot(km.boot, xlim=c(0,1),breaks=seq(0,1,by=0.05))
print(km.boot)










