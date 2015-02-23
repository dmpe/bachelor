library(psych)
library(FactoMineR)
# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
set.seed(5154)

source("RawData/DataFrame.R")
source("Imputation/MICE_Imputation.R")
# http://little-book-of-r-for-multivariate-analysis.readthedocs.org/en/latest/src/multivariateanalysis.html#principal-component-analysis
# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
# http://www.iiap.res.in/astrostat/School08/tuts/clus.html
# http://planspace.org/2013/02/03/pca-3d-visualization-and-clustering-in-r/
# eigen not possible due to non squer matrix
pc <- princomp(joinedDB.6, cor =FALSE, scores = TRUE)
plot(pc)
summary(pc)
pc$loadings
screeplot(pc, type='lines')
scree(joinedDB.6, factors=FALSE,pc=TRUE)
biplot(pc, var.axes =TRUE, cex = 0.8, main="(PCA) Biplot of Countries Data", xlim=c(-0.5, 0.6), ylim=c(-0.3, 0.7))
pc$loading



(pc$sdev)^2
sum((pc$loading[,1])^2)
# http://wiki.originlab.com/~originla/howto/index.php?title=Tutorial:Principal_Component_Analysis
#eigenvalues
tmp <- svd(joinedDB.6)
tmp$d


pcp <- prcomp(joinedDB.6)
summary(pcp)
comp <- data.frame(pcp$x[,1:4])
plot(comp, pch=16, col=rgb(0,0,0,0.5))
plot3d(comp$PC1, comp$PC2, comp$PC3, comp$PC4)

factorAn <- factanal(joinedDB.6, rotation = "none",factors =2)
factorAn$loadings
communality <- round(cbind(1 - factorAn$uniquenesses), 3)
sum(communality)/6
# An advanced method that "combines k-means cluster analysis with aspects of Factor Analysis 
# and PCA is offered by Vichi & Kiers (2001)" [p. 81].
outf <- FactorialKM(joinedDB.6, nclus = 2, ndim = 2, nstart=25, smartStart=TRUE)
print(outf)
plotrd(outf,what=c("all","none"), obslabel=rownames(joinedDB.6), density=FALSE)



# FactoMineR
# http://factominer.free.fr/classical-methods/principal-components-analysis.html
pcaFAS<-PCA(joinedDB.6, scale.unit = FALSE)
pcaFAS$eig
plot(pcaFAS, axes=c(1, 2), choix="ind", habillage="ind")











