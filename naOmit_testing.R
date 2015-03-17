summary(na.omit(joinedDB.8))
summary(joinedDB.8)

require(graphics)
DF <- data.frame(x = c(1, 2, 3), y = c(0, 10, NA))
summary(na.omit(DF))
summary(DF)


data(iris)
iris.na <- iris

## artificially drop some data values.
for (i in 1:2) iris.na[sample(23, sample(5)), i] <- NA

iris.imputed <- rfImpute(Species ~ ., iris.na)
iris.imputed <- round(iris.imputed[2:5], 1)

joinedDB.imputed <- rfImpute(CompletionRate ~ ., joinedDB.5)

print(imp <- mice(iris.na, m = 10))
iris.new <- complete(imp)

mean(na.omit(joinedDB.5$LearningCurve_Index))
summary(joinedDB.5)
sapply(na.omit(joinedDB.5), mean)
str(joinedDB.5)


library(conjoint)
data(czekolada)
simutil<-caBTL(csimp,cpref,cprof)
print("Percentage participation of profiles:", quote=FALSE)
print(simutil)


tidy_source("5_WeightingAggregation/WeAg.R")


abc <- matrix(data = 1:16, nrow = 4, ncol = 4, byrow = TRUE)
abc[1,1] <- 1
abc[1,2] <- 2
abc[1,3] <- 5
abc[1,4] <- 4
abc[2,1] <- 1/2
abc[2,2] <- 1
abc[2,3] <- 3
abc[2,4] <- 1.9
abc[3,1] <- 1/5
abc[3,2] <- 1/3
abc[3,3] <- 1
abc[3,4] <- 0.7
abc[4,1] <- 1/4
abc[4,2] <- 1/1.9
abc[4,3] <- 1/0.7
abc[4,4] <- 1

ahp(abc)




















