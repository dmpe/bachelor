library(mice)
library(VIM)
library(R2WinBUGS)
library(lattice)

set.seed(5154)
# source("1_RawData/DataFrame.R")
source("2_Imputation/UnsuperRF.R")

#' https://stackoverflow.com/questions/25966518/daisy-function-warning-message-nas-introduced-by-coercion
#' http://www.researchgate.net/post/What_is_the_proper_imputation_method_for_categorical_missing_value
#' http://www.stat.columbia.edu/~gelman/arm/missing.pdf
#' http://pj.freefaculty.org/guides/Rcourse/multipleImputation/multipleImputation-1-lecture.pdf
#' http://www.stefvanbuuren.nl/mi/docs/Utrecht-15MayCourse%20handout.pdf

#' qwr <- joinedDB.5[2:7]

#' First, I will analyse my complete data frame, which I build in previously described ch. 6.3.  As a result, we see no
#' surprises here. Five values are missing in the Learning Curve Index.  
#' The number of the missing values can be counted and visualized as follows:' (p. 8)
md.pattern(joinedDB.5[2:7])  # ‘country’ should be excluded for the analysis
#' Another way to study the pattern involves calculating the number of observations per patterns for all pairs of
#' variables.
#' md.pairs(joinedDB.5[2:7])

#' marginplot(qwr[4:5], col = mdc(1:2), cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3, pch = 19)

# mice [mice]
print(imp <- mice(joinedDB.5[2:7], m = 30, seed = 5154))

#' imp$predictorMatrix imp$loggedEvents imp$iteration imp$imp$LearningCurve_Index imp$visitSequence

#' The column fmi contains the fraction of missing information as defined in Rubin (1987), and the column lambda is the
#' proportion of the total variance that is attributable to the missing data (....; p. 14).
fit <- with(imp, lm(LearningCurve_Index ~ Freedom_Index + WEF_Score + Ranking_HIndex + CompletionRate + Unemployment))
print(pool(fit))
round(summary(pool(fit)), 2)

#' Post Imputation Graphical analysis
plot(imp, c("LearningCurve_Index"))
stripplot(imp, pch = 20, cex = 1.2)
#' xyplot(imp, LearningCurve_Index ~ Unemployment | .imp, pch = 20, cex = 1.4)
densityplot(imp, scales = list(x = list(relation = "free")))

#' This creates new data frame with 'old' column of countries (nat. preserving orders) -> Necessary
joinedDB.6 <- complete(imp, 15)
joinedDB.6$Country <- joinedDB.5$Country
joinedDB.6 <- joinedDB.6[, c(7, 1, 2, 3, 4, 5, 6)]  # Reorder them
joinedDB.6 <- data.frame(joinedDB.6[, -1], row.names = joinedDB.6[, 1])


#' Only for non scaled values, needs to be applied for later normalization
print(imp.nonScaled <- mice(nonScaledDataFrame[2:7], m = 30, seed = 5154))
plot(imp.nonScaled, c("LearningCurve_Index"))
densityplot(imp.nonScaled, scales = list(x = list(relation = "free")))
nonScaledDataFrame.complete <- complete(imp.nonScaled)
nonScaledDataFrame.complete$Country <- joinedDB.5$Country
nonScaledDataFrame.complete <- nonScaledDataFrame.complete[, c(7, 1, 2, 3, 4, 5, 6)]  # Reorder them

rfunsuper(joinedDB.5[2:7]) 

# To continue look in 'MultivariateAnalysis' folder, ->> and begin with 'Correlation.R', 
# then 'PCAandFA.R' and lastly with 'ClusterAnalysis.R'. All of them must be run. 

