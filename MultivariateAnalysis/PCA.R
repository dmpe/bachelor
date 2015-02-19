# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
set.seed(5154)

source("RawData/DataFrame.R")
source("Imputation/MICE_Imputation.R")
# http://little-book-of-r-for-multivariate-analysis.readthedocs.org/en/latest/src/multivariateanalysis.html#principal-component-analysis
# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
# http://www.iiap.res.in/astrostat/School08/tuts/clus.html
# http://planspace.org/2013/02/03/pca-3d-visualization-and-clustering-in-r/
# eigen not possible due to non squer matrix
pc <- princomp(joinedDB.6, cor =FALSE)
plot(pc)
summary(pc)
loadings(pc)
screeplot(pc, type='lines')
biplot(pc, var.axes =TRUE)
pc$loading[,1:4]

pcp <- prcomp(joinedDB.6)
summary(pcp)
comp <- data.frame(pcp$x[,1:4])
plot(comp, pch=16, col=rgb(0,0,0,0.5))
plot3d(comp$PC1, comp$PC2, comp$PC3, comp$PC4)
