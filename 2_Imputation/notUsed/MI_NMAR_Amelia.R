library(mi)
library(Amelia)
library(R2WinBUGS)

# NMAR Try

imp <- mice(joinedDB.5[2:7], m = 30, print = FALSE, seed = 5154)
post <- imp$post
k <- seq(1, 1.5, 0.1)
est <- vector("list", length(k))
for (i in 1:length(k)) {
  post["LearningCurve_Index"] <- paste("imp[[j]][,i] <-", k[i], "* imp[[j]][,i]")
  imp <- mice(joinedDB.5[2:7], post = post, seed = 5154, print = FALSE, maxit = 5)
  fit <- with(imp, lm(LearningCurve_Index ~ Ranking_HIndex + CompletionRate))
  est[[i]] <- summary(pool(fit))
}
print(est)
stripplot(imp, pch = 20, cex = 1.2)
# fit <- with(imp, lm(LearningCurve_Index ~ Unemployment + WEF_Score + Ranking_HIndex))
# print(pool(fit))
# round(summary(pool(fit)), 2)
densityplot(imp, scales = list(x = list(relation = 'free')))
joinedDB.6 <- complete(imp)



# mi [mi]

miinfo <- mi.info(joinedDB.5)
miinfo$imp.formula
sd <- mi(joinedDB.5, miinfo, n.iter = 50, seed = 5154)
sd
f <- mi.data.frame(sd)
converged(sd, check = "coefs")
f$LearningCurve_Index <- round(f$LearningCurve_Index, 3)
mi.continuous(LearningCurve_Index ~ Ranking_HIndex, data = joinedDB.5)
plot(sd)
plot(as.bugs.array(sd@mcmc))


# Amelia
a.out <- amelia(x = joinedDB.5[2:7], m = 10, boot.type = "none")
a.out$imputations$imp1
summary(a.out)
plot(a.out)
# write.amelia(a.out, file.stem = "train_and_test_imp") 
