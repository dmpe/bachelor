# Creates Data Frame of Weights


source("1_RawData/DataFrame.R")
source("2_Imputation/MICE_Imputation.R")
source("3_MultivariateAnalysis/PCAandFA.R")
source("4_Normalization/Scale.R")


factor1UnitNormalisation <- factorAn$loadings[,1]^2
factor2UnitNormalisation <- factorAn$loadings[,2]^2

weights.DB7 <- data.frame(Factor1Weight=round(factor1UnitNormalisation / sum(factorAn$loadings[,1]^2),3),
                          Factor2Weight=round(factor2UnitNormalisation / sum(factorAn$loadings[,2]^2),3))












