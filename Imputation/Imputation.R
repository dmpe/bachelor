
library(mice)
library(VIM)
library(mi)
# https://stackoverflow.com/questions/25966518/daisy-function-warning-message-nas-introduced-by-coercion
# to "Read the data in as factor variables instead of characters."
# http://www.researchgate.net/post/What_is_the_proper_imputation_method_for_categorical_missing_value
# http://www.stat.columbia.edu/~gelman/arm/missing.pdf
joinedDB.5$Country <- factor(joinedDB.5$Country)

qwr <- joinedDB.5[2:7]
# "The number of the missing values can be counted and visualized as follows:" (p. 8)
md.pattern(joinedDB.5[2:7])
# "Another way to study the pattern involves calculating the number of observations per patterns
# for all pairs of variables."
md.pairs(joinedDB.5[2:7])

marginplot(qwr[, c("CompletionRate", "LearningCurveRanking")], col = mdc(1:2), cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3, pch = 19)

# mi
sd<-mi(joinedDB.5,mi.info(joinedDB.5), n.iter = 10)
f<-mi.data.frame(sd)
f$LearningCurveRanking <-round(f$LearningCurveRanking,0)

# mice
print(imp <- mice(joinedDB.5, m=10))
joinedDB.6 <- complete(imp)

stripplot(imp, pch = 20, cex = 1.2)
fit <- with(imp, lm(LearningCurveRanking ~ Ranking_EDB + Ranking_WEF + JournalArticles))
print(pool(fit))
round(summary(pool(fit)), 2)
densityplot(imp, scales = list(x = list(relation = "free")))

