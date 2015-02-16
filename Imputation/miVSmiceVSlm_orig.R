
library(mice)
library(VIM)
library(mi)
library(ggplot2)

# http://thomasleeper.com/Rcourse/Tutorials/mi.html

# GENERALLy, wrong. Because Predict with case deletion
summary(joinedDB.5)
lm <- lm(Ranking_LearningCurve ~ Ranking_EDB + Ranking_WEF + Ranking_HIndex + CompletionRate + Unemployment,data=joinedDB.5 )
#summary(lm)

# p <- qplot(Ranking_LearningCurve, Ranking_HIndex, data = joinedDB.5)
# p + geom_abline(intercept = 40502.2572   , slope = -767.5146 )
# coef(lm(joinedDB.5$Ranking_HIndex ~ joinedDB.5$Ranking_LearningCurve)) 
s.orig <- coef(summary(lm))[, 1:2]  # original results
s.orig

# MI

#mp.plot(joinedDB.5)
mi.info(joinedDB.5)
imputMI <- mi(joinedDB.5, mi.info(joinedDB.5), n.imp = 30, n.iter = 30, seed =5154)
convergence.plot(imputMI)
input.mi.df <- mi.data.frame(imputMI)
input.mi.df$Ranking_LearningCurve <- round(input.mi.df$Ranking_LearningCurve,0)
input.mi.out <- lm.mi(RRanking_LearningCurve ~ Ranking_EDB + Ranking_WEF + Ranking_HIndex + CompletionRate + Unemployment, imputMI)
display(input.mi.out)

s.mi <- cbind(coefficients = coef(input.mi.out), standError = se.coef(input.mi.out))
s.mi


# MICE
print(imputMICE <- mice(joinedDB.5[2:7],  m=30, seed=5154, maxit = 30))
# stripplot(imputMICE, pch = 20, cex = 1.2)
input.mice.out <- with(imputMICE, lm(Ranking_LearningCurve ~ Ranking_EDB + Ranking_WEF + Ranking_HIndex + CompletionRate + Unemployment))
summary(input.mice.out)
input.mice.pool <- pool(input.mice.out)
s.mice <- round(summary(input.mice.pool), 2)[, 1:2]
s.mice
# densityplot(imputMICE, scales = list(x = list(relation = "free")))
joinedDB.6 <- complete(imputMICE)

allout <- cbind(s.mi[, 1], s.mice[, 1], s.orig[,1])
colnames(allout) <- c("MI", "mice", "Original")
allout

# different
# coef(lm(joinedDB.6$Ranking_HIndex ~ joinedDB.6$Ranking_LearningCurve)) 

# p <- qplot(Ranking_LearningCurve, Ranking_HIndex, data = joinedDB.6)
# p + geom_abline(intercept = 37228.77   , slope = -714.56 )
# 
# r <- qplot(Ranking_LearningCurve, Ranking_HIndex, data = input.mi.df)
# r + geom_abline(intercept =34715.4501   , slope = 472.7491 )


