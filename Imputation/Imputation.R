library(mice)
library(VIM)
library(mi)
library(R2WinBUGS)
# Ressources:

# https://stackoverflow.com/questions/25966518/daisy-function-warning-message-nas-introduced-by-coercion
# to "Read the data in as factor variables instead of characters."
# http://www.researchgate.net/post/What_is_the_proper_imputation_method_for_categorical_missing_value
# http://www.stat.columbia.edu/~gelman/arm/missing.pdf
# http://thomasleeper.com/Rcourse/Tutorials/mi.html
# http://pj.freefaculty.org/guides/Rcourse/multipleImputation/multipleImputation-1-lecture.pdf
# http://www.stefvanbuuren.nl/mi/docs/Utrecht-15MayCourse%20handout.pdf
joinedDB.5$Country <- factor(joinedDB.5$Country)

qwr <- joinedDB.5[2:7]
# "The number of the missing values can be counted and visualized as follows:" (p. 8)
md.pattern(joinedDB.5[2:7])
# "Another way to study the pattern involves calculating the number of observations per patterns
# for all pairs of variables."
# md.pairs(joinedDB.5[2:7])

marginplot(qwr[4:5], col = mdc(1:2), cex = 1.2, cex.lab = 1.2, cex.numbers = 1.3, pch = 19)

# mi
# miinfo <- mi.info(joinedDB.5)
# miinfo$imp.formula
# sd<-mi(joinedDB.5, miinfo, n.iter = 100)
# f<-mi.data.frame(sd)
# converged(joinedDB.5, check = "data")
# f$Ranking_LearningCurve <- round(f$Ranking_LearningCurve,0)
# mi.continuous(Ranking_LearningCurve ~ Ranking_HIndex, data = joinedDB.5)
# plot(sd)
# plot(as.bugs.array(sd@mcmc))

# mice
print(imp <- mice(joinedDB.5[2:7], m=20))
imp$predictorMatrix
imp$loggedEvents
imp$iteration
imp$imp$Ranking_LearningCurve
imp$visitSequence
stripplot(imp, pch = 20, cex = 1.2)
#fit <- with(imp, lm(Ranking_LearningCurve ~ Ranking_EDB + Ranking_WEF + Ranking_HIndex))
#print(pool(fit))
#round(summary(pool(fit)), 2)
densityplot(imp, scales = list(x = list(relation = "free")))
joinedDB.6 <- complete(imp)

plot(imp, c("Ranking_LearningCurve"))





