
library(mice)
library(VIM)
library(mi)
library(ggplot2)

# http://thomasleeper.com/Rcourse/Tutorials/mi.html

# GENERALLy, wrong. Because Predict with case deletion
#summary(joinedDB.5)
lm <- lm(LearningCurve_Index ~ Freedom_Index + WEF_Score + Ranking_HIndex + CompletionRate + Unemployment, data=joinedDB.5[2:7] )
#summary(lm)

# p <- qplot(Ranking_LearningCurve, Ranking_HIndex, data = joinedDB.5)
# p + geom_abline(intercept = 40502.2572   , slope = -767.5146 )
# coef(lm(joinedDB.5$Ranking_HIndex ~ joinedDB.5$Ranking_LearningCurve)) 
s.orig <- coef(summary(lm))[, 1:2]  # original results
s.orig

# MI
# mp.plot(joinedDB.5)
mi.info(joinedDB.5[2:7])
imputMI <- mi(joinedDB.5[2:7], mi.info(joinedDB.5[2:7]), n.imp = 30, n.iter = 6, seed =5154)
convergence.plot(imputMI)
input.mi.df <- mi.data.frame(imputMI)
input.mi.out <- lm.mi(LearningCurve_Index ~ Freedom_Index + WEF_Score + Ranking_HIndex + CompletionRate + Unemployment, imputMI)
# display(input.mi.out)
coef.mi <- input.mi.out@mi.pooled
s.mi <- do.call(cbind, coef.mi)  

# MICE
print(imputMICE <- mice(joinedDB.5[2:7],  m=30, seed=5154, maxit = 6))
# stripplot(imputMICE, pch = 20, cex = 1.2)
input.mice.out <- with(imputMICE, lm(LearningCurve_Index ~ Freedom_Index + WEF_Score + Ranking_HIndex + CompletionRate + Unemployment))
summary(input.mice.out)
input.mice.pool <- pool(input.mice.out)
s.mice <- summary(input.mice.pool)[, 1:2]
s.mice
# densityplot(imputMICE, scales = list(x = list(relation = "free")))
joinedDB.6 <- complete(imputMICE)

compareThemAll <- cbind(s.mi[, 1], s.mice[, 1], s.orig[,1])
colnames(compareThemAll) <- c("MI", "mice", "Original")
compareThemAll


