



imp <- mice(joinedDB.5, m=10, print = FALSE)
post <- imp$post

k <- seq(1, 1.5, 0.1)
est <- vector("list", length(k))

for (i in 1:length(k)) {

post["Ranking_LearningCurve"] <- paste("imp[[j]][,i] <-", k[i], "* imp[[j]][,i]")

imp <- mice(joinedDB.5, post = post, seed = 10, print = FALSE, maxit = 20)

fit <- with(imp, lm(Ranking_LearningCurve ~ Ranking_HIndex))
est[[i]] <- summary(pool(fit))

}
print(est)
#stripplot(imp, pch = 20, cex = 1.2)
fit <- with(imp, lm(LearningCurveRanking ~ Ranking_EDB + Ranking_WEF + JournalArticles))
print(pool(fit))
round(summary(pool(fit)), 2)
# densityplot(imp, scales = list(x = list(relation = "free")))
joinedDB.6 <- complete(imp)
