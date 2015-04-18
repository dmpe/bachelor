set.seed(5154)

# source("1_RawData/DataFrame.R")
# source("2_Imputation/Imputation.R")
# source("3_Normalization/Scale.R")
# source("4_MultivariateAnalysis/PCAandFA.R")


#######################################################
#' http://cran.r-project.org/web/packages/Compind/Compind.pdf
#' http://cran.r-project.org/web/packages/conjoint/conjoint.pdf
#' https://stats.stackexchange.com/questions/63546/comparing-hierarchical-clustering-dendrograms-obtained-by-different-distances/63549#63549
#' https://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters?rq=1
#' http://sites.stat.psu.edu/~ajw13/stat505/fa06/17_factor/13_factor_varimax.html 
#' https://stackoverflow.com/questions/24497186/rowwise-maximum-for-r
#' http://stackoverflow.com/questions/3643555/multiply-rows-of-matrix-by-vector
# library(Compind)
#######################################################


# factorAn
factor1SquaredLoadings <- factorAn$loadings[, 1]^2
factor2SquaredLoadings <- factorAn$loadings[, 2]^2

#' factor3UnitNormalisation <- factorAn$loadings[, 3]^2

Sum_SFL <- sum(factor1SquaredLoadings) + sum(factor2SquaredLoadings) # + sum(factorAn$loadings[, 3]^2)

FactorWeight1 <- sum(factor1SquaredLoadings)/Sum_SFL
FactorWeight2 <- sum(factor2SquaredLoadings)/Sum_SFL

#' FactorWeight3 <- sum(factorAn$loadings[, 3]^2)/Sum_SFL

df.weights <- data.frame(Factor1ScaledWeight = factor1SquaredLoadings/sum(factor1SquaredLoadings), 
                         Factor2ScaledWeight = factor2SquaredLoadings/sum(factor2SquaredLoadings))

df.weights$colMax <- apply(df.weights, 1, function(x) max(x[])) # rowwise

df.weights$WholeFactorWeight <- c(FactorWeight2, FactorWeight1, FactorWeight2, 
                                  FactorWeight2, FactorWeight1, FactorWeight2)

df.weights$Multipl <- df.weights$colMax * df.weights$WholeFactorWeight
df.weights$UnitScaled <- round(df.weights$Multipl / sum(df.weights$Multipl), 4)

# round(df.weights$colMax ,3)
# sum(df.weights$colMax)


#' Min-MAX + FA weights
minMaxMultiFA.Weights <- t(t(df.Original.MinMax) * df.weights$UnitScaled)
df.Original.MM.FA <- sort(rowSums(minMaxMultiFA.Weights), decreasing = T)
df.Original.MM.FA <- data.frame(Value = df.Original.MM.FA, RankMM.FA = seq(1:23))

#' Min-MAX + EW
minMaxMultiEqual.Weights <- t(t(df.Original.MinMax) * c(rep(1/6, 6)))
df.Original.MM.EW <- sort(rowSums(minMaxMultiEqual.Weights), decreasing = T)
df.Original.MM.EW <- data.frame(Value = df.Original.MM.EW, RankMM.EW = seq(1:23))

#' Min-MAX + My own choice
minMaxMultiMyChoice.Weights <- t(t(df.Original.MinMax) * c(0.140, 0.170, 0.230, 0.220, 0.130, 0.110))
df.Original.MM.MyChoice <- sort(rowSums(minMaxMultiMyChoice.Weights), decreasing = T)
df.Original.MM.MyChoice <- data.frame(Value = df.Original.MM.MyChoice, RankMM.MC = seq(1:23))


# #' ZSCORE + FA
# zscoreMultiFA.Weights <- t(t(df.Zscore.ImputedUnempCorrect) * df.weights$UnitScaled)
# df.Zscore.FA <- sort(rowSums(zscoreMultiFA.Weights), decreasing = T)
# df.Zscore.FA <- data.frame(Value = df.Zscore.FA, RankZS.FA = seq(1:23))

# #' Zscore + EW
# zscoreMultiEqual.Weights <- t(t(df.Zscore.ImputedUnempCorrect) * c(rep(1/6, 6)))
# df.Zscore.EW <- sort(rowSums(zscoreMultiEqual.Weights), decreasing = T)
# df.Zscore.EW <- data.frame(Value = df.Zscore.EW, RankZS.EW = seq(1:23))

# normalise_ci(nonScaledCompleteDF, c(1:3), c("NEG", "POS", "POS"), method=1)

