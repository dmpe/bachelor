
library(mice)

md.pattern(joinedDB.9[2:8])
print(imp <- mice(joinedDB.9[2:8], m=10))
complete(imp)
stripplot(imp, pch = 20, cex = 1.2)
fit <- with(imp, lm(LearningCurveRanking ~ Ranking_EDB + Ranking_WEF))
print(pool(fit))
round(summary(pool(fit)), 2)
densityplot(imp, scales = list(x = list(relation = "free")))

