# library("Benchmarking")
# library("pmr")

#' http://cran.r-project.org/web/packages/Compind/Compind.pdf
#' http://cran.r-project.org/web/packages/conjoint/conjoint.pdf
#' https://stats.stackexchange.com/questions/63546/comparing-hierarchical-clustering-dendrograms-obtained-by-different-distances/63549#63549
#' https://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters?rq=1
#' http://sites.stat.psu.edu/~ajw13/stat505/fa06/17_factor/13_factor_varimax.html 
#' https://stackoverflow.com/questions/24497186/rowwise-maximum-for-r
#' 
#' Creates Data Frame of Weights
# set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/MICE_Imputation.R")
# source("3_MultivariateAnalysis/PCAandFA.R")
# source("4_Normalization/Scale.R")

# factorAn
factor1UnitNormalisation <- factorAn$loadings[, 1]^2
factor2UnitNormalisation <- factorAn$loadings[, 2]^2
#' factor3UnitNormalisation <- factorAn$loadings[, 3]^2

Sum_SFL <- sum(factorAn$loadings[, 1]^2) + sum(factorAn$loadings[, 2]^2) # + sum(factorAn$loadings[, 3]^2)

FactorWeight1 <- sum(factorAn$loadings[, 1]^2)/Sum_SFL
FactorWeight2 <- sum(factorAn$loadings[, 2]^2)/Sum_SFL
#' FactorWeight3 <- sum(factorAn$loadings[, 3]^2)/Sum_SFL

weights.DB7 <- data.frame(Factor1Weight = factor1UnitNormalisation/sum(factorAn$loadings[, 1]^2), 
                          Factor2Weight = factor2UnitNormalisation/sum(factorAn$loadings[, 2]^2))

weights.DB7$colMax <- apply(weights.DB7, 1, function(x) max(x[]))
weights.DB7$FactorWeight <- c(FactorWeight2, FactorWeight1, FactorWeight2, FactorWeight2, FactorWeight1, FactorWeight2)
weights.DB7$Multipl <- weights.DB7$colMax * weights.DB7$FactorWeight
weights.DB7$UnitScaled <- round(weights.DB7$Multipl / sum(weights.DB7$Multipl), 4)


# ci_factor(joinedDB.7, method = "ALL")
# asd<-ci_mean_geom(joinedDB.7)
# sort(asd$ci_mean_geom_est)

#' http://stackoverflow.com/questions/3643555/multiply-rows-of-matrix-by-vector
#' Min-MAX + FA weights.
minMaxMultiFA.Weights <- t(t(joinedDB.7) * weights.DB7$UnitScaled)
joinedDB.8 <- sort(rowSums(minMaxMultiFA.Weights), decreasing = T)
joinedDB.8 <- data.frame(Value = joinedDB.8, RankMM.FA = seq(1:23))

#' Min-MAX + EW
minMaxMultiEqual.Weights <- t(t(joinedDB.7) * c(rep(1/6, 6)))
joinedDB.9 <- sort(rowSums(minMaxMultiEqual.Weights), decreasing = T)
joinedDB.9 <- data.frame(Value = joinedDB.9, RankMM.EW = seq(1:23))

#' ZSCORE + FA
zscoreMultiFA.Weights <- t(t(joinedDB.6) * weights.DB7$UnitScaled)
joinedDB.10 <- sort(rowSums(zscoreMultiFA.Weights), decreasing = T)
joinedDB.10 <- data.frame(Value = joinedDB.10, RankZS.FA = seq(1:23))

#' Zscore + EW
zscoreMultiEqual.Weights <- t(t(joinedDB.6) * c(rep(1/6, 6)))
joinedDB.11 <- sort(rowSums(zscoreMultiEqual.Weights), decreasing = T)
joinedDB.11 <- data.frame(Value = joinedDB.11, RankZS.EW = seq(1:23))




