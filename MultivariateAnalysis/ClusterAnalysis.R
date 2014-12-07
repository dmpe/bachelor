

library(fpc)
library(mclust)
library(cluster)

dfa = df[2:8]
dfa <- scale(dfa)

pamk(dfa)
# http://www.statmethods.net/advstats/cluster.html
wss <- (nrow(dfa)-1)*sum(apply(dfa,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(dfa,centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares") 


fit <- kmeans(dfa, 3) # 5 cluster solution
fit

fit$cluster

plot(fit)
# get cluster means
aggregate(dfa,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(dfa, fit$cluster) 


fit <- Mclust(dfa)
plot(fit) # plot results
summary(fit) # display the best model 


clusplot(dfa, fit$cluster, color=TRUE, shade=TRUE,
         labels=2, lines=0)

         

# Hierarchical Clustering
euroclust<-hclust(dist(df[2:8]))
plot(euroclust, labels=df$Country)

# Centroid Plot against 1st 2 discriminant functions
plotcluster(dfa, fit$centers) 



# https://stats.stackexchange.com/questions/31083/how-to-produce-a-pretty-plot-of-the-results-of-k-means-cluster-analysis
km    <- kmeans(df[2:8],3)
dissE <- daisy(df[2:8]) 
dE2   <- dissE^2
sk2   <- silhouette(km$cl, dE2)
plot(sk2)

