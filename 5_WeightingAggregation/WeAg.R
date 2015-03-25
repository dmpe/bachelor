library("Compind")

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
factor1SquaredLoadings <- factorAn$loadings[, 1]^2
factor2SquaredLoadings <- factorAn$loadings[, 2]^2

#' factor3UnitNormalisation <- factorAn$loadings[, 3]^2

Sum_SFL <- sum(factor1SquaredLoadings) + sum(factor2SquaredLoadings) # + sum(factorAn$loadings[, 3]^2)

FactorWeight1 <- sum(factor1SquaredLoadings)/Sum_SFL
FactorWeight2 <- sum(factor2SquaredLoadings)/Sum_SFL

#' FactorWeight3 <- sum(factorAn$loadings[, 3]^2)/Sum_SFL

weights.DB7 <- data.frame(Factor1ScaledWeight = factor1SquaredLoadings/sum(factor1SquaredLoadings), 
                          Factor2ScaledWeight = factor2SquaredLoadings/sum(factor2SquaredLoadings))

weights.DB7$colMax <- apply(weights.DB7, 1, function(x) max(x[]))

weights.DB7$WholeFactorWeight <- c(FactorWeight2, FactorWeight1, FactorWeight2, 
                              FactorWeight2, FactorWeight1, FactorWeight2)

weights.DB7$Multipl <- weights.DB7$colMax * weights.DB7$WholeFactorWeight
weights.DB7$UnitScaled <- round(weights.DB7$Multipl / sum(weights.DB7$Multipl), 4)

# round(weights.DB7$colMax ,3)
# sum(weights.DB7$colMax)

# normalise_ci(nonScaledCompleteDF, c(1:3), c("NEG", "POS", "POS"), method=1)

#' http://stackoverflow.com/questions/3643555/multiply-rows-of-matrix-by-vector
#' Min-MAX + FA weights.
minMaxMultiFA.Weights <- t(t(df.Original.MinMax) * weights.DB7$UnitScaled)
df.Original.MM.FA <- sort(rowSums(minMaxMultiFA.Weights), decreasing = T)
df.Original.MM.FA <- data.frame(Value = df.Original.MM.FA, RankMM.FA = seq(1:23))

#' Min-MAX + EW
minMaxMultiEqual.Weights <- t(t(df.Original.MinMax) * c(rep(1/6, 6)))
df.Original.MM.EW <- sort(rowSums(minMaxMultiEqual.Weights), decreasing = T)
df.Original.MM.EW <- data.frame(Value = df.Original.MM.EW, RankMM.EW = seq(1:23))

#' ZSCORE + FA
zscoreMultiFA.Weights <- t(t(df.Zscore.Imputed) * weights.DB7$UnitScaled)
df.Zscore.FA <- sort(rowSums(zscoreMultiFA.Weights), decreasing = T)
df.Zscore.FA <- data.frame(Value = df.Zscore.FA, RankZS.FA = seq(1:23))

#' Zscore + EW
zscoreMultiEqual.Weights <- t(t(df.Zscore.Imputed) * c(rep(1/6, 6)))
df.Zscore.EW <- sort(rowSums(zscoreMultiEqual.Weights), decreasing = T)
df.Zscore.EW <- data.frame(Value = df.Zscore.EW, RankZS.EW = seq(1:23))

