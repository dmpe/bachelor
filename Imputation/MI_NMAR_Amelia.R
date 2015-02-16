

# NMAR Try

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
stripplot(imp, pch = 20, cex = 1.2)
fit <- with(imp, lm(LearningCurveRanking ~ Ranking_EDB + Ranking_WEF + JournalArticles))
print(pool(fit))
round(summary(pool(fit)), 2)
# densityplot(imp, scales = list(x = list(relation = "free")))
joinedDB.6 <- complete(imp)



# mi [mi]

miinfo <- mi.info(joinedDB.5)
miinfo$imp.formula
sd<-mi(joinedDB.5, miinfo, n.iter = 100)
f<-mi.data.frame(sd)
converged(joinedDB.5, check = "data")
f$Ranking_LearningCurve <- round(f$Ranking_LearningCurve,0)
mi.continuous(Ranking_LearningCurve ~ Ranking_HIndex, data = joinedDB.5)
plot(sd)
plot(as.bugs.array(sd@mcmc))


# Amelia
a.out <- amelia(x = joinedDB.5[2:7], m = 10, boot.type = "none")
summary(a.out)
plot(a.out)
write.amelia( a.out, file.stem = 'train_and_test_imp')
