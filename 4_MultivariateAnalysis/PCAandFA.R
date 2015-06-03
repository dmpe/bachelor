library(psych)

set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
# source("3_Normalization/Scale.R")

################################
#' http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/
#' http://little-book-of-r-for-multivariate-analysis.readthedocs.org/en/latest/src/multivariateanalysis.html#principal-component-analysis
#' http://www.iiap.res.in/astrostat/School08/tuts/clus.html
#' http://planspace.org/2013/02/03/pca-3d-visualization-and-clustering-in-r/
#' http://sites.stat.psu.edu/~ajw13/stat505/fa06/16_princomp/07_princomp_alternative.html
#' http://wiki.originlab.com/~originla/howto/index.php?title=Tutorial:Principal_Component_Analysis 
#' http://www.statoek.wiso.uni-goettingen.de/veranstaltungen/Multivariate/Daten/mvsec5.pdf
#' http://factominer.free.fr/classical-methods/principal-components-analysis.html
#' http://www.r-bloggers.com/identifying-records-in-data-frame-a-that-are-not-contained-in-data-frame-b-%E2%80%93-a-comparison/
#' library(FactoMineR)
#' library(clustrd)
#' library(rgl)
################################

pc2 <- prcomp(df.Original.MinMax, center = TRUE, scale = FALSE)
summary(pc2)
as.data.frame(round(pc2$rotation, 3))

varimax(pc2$rotation)

# screeplot(pc2, type = "lines")
scree(df.Original.MinMax, factors = TRUE, pc = TRUE)

factorAn <- factanal(df.Original.MinMax, rotation = "varimax", factors = 2)
factorAn  # SS is sum of squares 
communality <- round(cbind(1 - factorAn$uniquenesses), 3)
communality
sum(communality)/6

#' promax(loadings(factorAn))

######################################
#' An advanced method that 'combines k-means cluster analysis with aspects of Factor Analysis and PCA is offered by Vichi &
#' Kiers (2001)' [p. 81].
#' outf <- FactorialKM(df.Zscore.Imputed, nclus = 2, ndim = 2, nstart = 25, smartStart = TRUE)
#' print(outf)
#' plotrd(outf, what = c("all", "none"), obslabel = rownames(df.Zscore.Imputed), density = FALSE)


#' FactoMineR
#' pcaFAS <- PCA(df.Zscore.Imputed, scale.unit = TRUE)
#' round(pcaFAS$eig, 3)
#' plot(pcaFAS, axes = c(1, 2), choix = "ind", habillage = "ind")

