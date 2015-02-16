library(mice)
library(VIM)
library(R2WinBUGS)
library(lattice)
# Ressources:

# https://stackoverflow.com/questions/25966518/daisy-function-warning-message-nas-introduced-by-coercion
# http://www.researchgate.net/post/What_is_the_proper_imputation_method_for_categorical_missing_value
# http://www.stat.columbia.edu/~gelman/arm/missing.pdf
# http://pj.freefaculty.org/guides/Rcourse/multipleImputation/multipleImputation-1-lecture.pdf
# http://www.stefvanbuuren.nl/mi/docs/Utrecht-15MayCourse%20handout.pdf
# to "Read the data in as factor variables instead of characters."
# joinedDB.5$Country <- factor(joinedDB.5$Country)

qwr <- joinedDB.5[2:7]

# First, I will analyse my complete data frame, which I build in previously described ch. 6.3. 
# As a result, we see no surprises here. Five values are missing in the Learning Curve Index.
# "The number of the missing values can be counted and visualized as follows:" (p. 8)
md.pattern(joinedDB.5[2:7]) # ‘country’ should be excluded for the analysis

# "Another way to study the pattern involves calculating the number of observations per patterns
# for all pairs of variables."
# md.pairs(joinedDB.5[2:7])

marginplot(qwr[4:5], col = mdc(1:2), cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3, pch = 19)

# mice [mice]
print(imp <- mice(joinedDB.5[2:7], m=30, seed=5154))

imp$predictorMatrix
imp$loggedEvents
imp$iteration
imp$imp$Ranking_LearningCurve
imp$visitSequence

# The column fmi contains the
# fraction of missing information as defined in Rubin (1987), and the column lambda is the
# proportion of the total variance that is attributable to the missing data (....; p. 14).
fit <- with(imp, lm(Ranking_LearningCurve ~ Ranking_EDB + Ranking_WEF + Ranking_HIndex + CompletionRate + Unemployment))
print(pool(fit))
round(summary(pool(fit)), 2)

# Post Imputation Graphical analysis
plot(imp, c("Ranking_LearningCurve"))
stripplot(imp, pch = 20, cex = 1.2)
xyplot(imp, Ranking_LearningCurve ~  Unemployment | .imp, pch = 20, cex = 1.4)
densityplot(imp, scales = list(x = list(relation = "free")))

# This creates new data frame with "old" column of countries (nat. preserving orders)
# Necessary
joinedDB.6 <- complete(imp)
joinedDB.6$Country <- joinedDB.5$Country
joinedDB.6 <- joinedDB.6[ ,c(7,1,2,3,4,5,6)] # Reorder them







