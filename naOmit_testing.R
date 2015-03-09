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
