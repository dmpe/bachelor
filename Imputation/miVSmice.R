
library(mice)
library(VIM)
library(mi)
library(ggplot2)


# GENERAL
summary(joinedDB.5)
lm <- lm(joinedDB.5$JournalArticles ~ joinedDB.5$LearningCurveRanking)
#summary(lm)

p <- qplot(LearningCurveRanking, JournalArticles, data = joinedDB.5)
p + geom_abline(intercept = 40502.2572   , slope = -767.5146 )
# coef(lm(joinedDB.5$JournalArticles ~ joinedDB.5$LearningCurveRanking)) 
s.orig <- coef(summary(lm))[, 1:2]  # original results
s.orig

# MI

#mp.plot(joinedDB.5)
mi.info(joinedDB.5)
imputMI <- mi(joinedDB.5, mi.info(joinedDB.5), n.imp = 10, n.iter = 10)
convergence.plot(imputMI)
input.mi.df <- mi.data.frame(imputMI)
input.mi.df$LearningCurveRanking <- round(input.mi.df$LearningCurveRanking,0)

input.mi.out <- lm.mi(JournalArticles ~ LearningCurveRanking, imputMI)
display(input.mi.out)

s.mi <- cbind(coefficients = coef(input.mi.out), standError = se.coef(input.mi.out))
s.mi


# MICE

print(imputMICE <- mice(joinedDB.5, m = 10, maxit = 10))
# stripplot(imputMICE, pch = 20, cex = 1.2)
input.mice.out <- with(imputMICE, lm(JournalArticles ~ LearningCurveRanking))
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
# coef(lm(joinedDB.6$JournalArticles ~ joinedDB.6$LearningCurveRanking)) 

p <- qplot(LearningCurveRanking, JournalArticles, data = joinedDB.6)
p + geom_abline(intercept = 37228.77   , slope = -714.56 )

r <- qplot(LearningCurveRanking, JournalArticles, data = input.mi.df)
r + geom_abline(intercept =34715.4501   , slope = 472.7491 )


