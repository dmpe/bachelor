library("Benchmarking")
library("Compind")
# http://cran.r-project.org/web/packages/Compind/Compind.pdf
# http://cran.r-project.org/web/packages/conjoint/conjoint.pdf
# Creates Data Frame of Weights
set.seed(5154)

source("1_RawData/DataFrame.R")
source("2_Imputation/MICE_Imputation.R")
source("3_MultivariateAnalysis/PCAandFA.R")
source("4_Normalization/Scale.R")

factorAn
factor1UnitNormalisation <- factorAn$loadings[,1]^2
factor2UnitNormalisation <- factorAn$loadings[,2]^2

weights.DB7 <- data.frame(Factor1Weight=round(factor1UnitNormalisation / sum(factorAn$loadings[,1]^2),3),
                          Factor2Weight=round(factor2UnitNormalisation / sum(factorAn$loadings[,2]^2),3))


ci_bod(joinedDB.7)
ci_factor(joinedDB.7, method = "ALL")
ci_mean_geom(joinedDB.7)


# DEA
# http://professorjf.webs.com/DEA%202013.pdf

ahp(joinedDB.7[1:6,2:6])


