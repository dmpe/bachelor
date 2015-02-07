
library(mice)

md.pattern(joinedDB.5[1:7])

print(imp <- mice(joinedDB.5[1:7], m=10))

joinedDB.6 <- complete(imp)

stripplot(imp, pch = 20, cex = 1.2)
fit <- with(imp, lm(LearningCurveRanking ~ Ranking_EDB + Ranking_WEF + JournalArticles))
print(pool(fit))
round(summary(pool(fit)), 2)
densityplot(imp, scales = list(x = list(relation = "free")))

