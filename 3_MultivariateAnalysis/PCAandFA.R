library(psych)
# library(FactoMineR)
# library(clustrd)
# library(rgl)

#' http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
#' http://little-book-of-r-for-multivariate-analysis.readthedocs.org/en/latest/src/multivariateanalysis.html#principal-component-analysis
#' http://www.iiap.res.in/astrostat/School08/tuts/clus.html
#' http://planspace.org/2013/02/03/pca-3d-visualization-and-clustering-in-r/
#' http://sites.stat.psu.edu/~ajw13/stat505/fa06/16_princomp/07_princomp_alternative.html
#' http://wiki.originlab.com/~originla/howto/index.php?title=Tutorial:Principal_Component_Analysis 
#' http://www.statoek.wiso.uni-goettingen.de/veranstaltungen/Multivariate/Daten/mvsec5.pdf
#' http://factominer.free.fr/classical-methods/principal-components-analysis.html
#' http://www.r-bloggers.com/identifying-records-in-data-frame-a-that-are-not-contained-in-data-frame-b-%E2%80%93-a-comparison/

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
# source("4_Normalization/Scale.R")

#' Therefore, principal component analysis using the standardized data is equivalent to principal component analysis using
#' the correlation matrix.  

#' NOT RECOMMENDED
#' pcaNOT <- princomp(df.Zscore.Imputed, cor = FALSE, scores = TRUE)
#' plot(pcaNOT)
#' summary(pcaNOT)
#' screeplot(pcaNOT, type = "lines")
#' scree(df.Zscore.Imputed, factors = TRUE, pc = TRUE)
#' biplot(pcaNOT, var.axes = TRUE, cex = 0.8, main = "(PCA) Biplot of Countries Data", xlim = c(-0.5, 0.6), ylim = c(-0.3, 0.7), arrow.len = 0.15)
#' round(pcaNOT$loading, 3)
#' round(pcaNOT$sdev, 3)
#' round(pcaNOT$scores, 3)

#' (pcaNOT$sdev)^2 
#' sum((pcaNOT$loading[,1])^2) 
#' eigenvalues 
#' tmp <- svd(df.Zscore.Imputed)  df.Original.MinMax
#' tmp
pc2 <- prcomp(df.Original.MinMax, center = TRUE, scale = FALSE)
summary(pc2)
#' This is using singular value decomposition
pc1 <- prcomp(df.Zscore.Imputed, center = TRUE, scale = FALSE)
summary(pc1)
t1<-round(pc1$rotation, 3)
t2<-round(pc2$rotation, 3)
t1.1 <- as.data.frame(t1)
t2.1 <- as.data.frame(t2)
t1.1
t2.1
fun.12(t1.1,t2.1)
# screeplot(pc, type = "lines")
scree(df.Zscore.Imputed, factors = TRUE, pc = TRUE)

#' comp <- data.frame(pc$x[,1:4]) 
#' plot(comp, pch=16, col=rgb(0,0,0,0.5)) 
#' plot3d(comp$PC1, comp$PC2, comp$PC3, comp$PC4)


factorAn <- factanal(df.Zscore.Imputed, rotation = "varimax", factors = 2)
factorAn  # SS is sum of squares 
communality <- round(cbind(1 - factorAn$uniquenesses), 3)
communality
sum(communality)/6 # maybe to consider as a threashold of communality


#' promax(loadings(pcaNOT))
promax(loadings(factorAn))

#' An advanced method that 'combines k-means cluster analysis with aspects of Factor Analysis and PCA is offered by Vichi &
#' Kiers (2001)' [p. 81].
#' outf <- FactorialKM(df.Zscore.Imputed, nclus = 2, ndim = 2, nstart = 25, smartStart = TRUE)
#' print(outf)
#' plotrd(outf, what = c("all", "none"), obslabel = rownames(df.Zscore.Imputed), density = FALSE)


#' FactoMineR
#' pcaFAS <- PCA(df.Zscore.Imputed, scale.unit = TRUE)
#' round(pcaFAS$eig, 3)
#' plot(pcaFAS, axes = c(1, 2), choix = "ind", habillage = "ind")
 
