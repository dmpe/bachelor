library(corrplot)
library(ellipse)

set.seed(5154)

summary(joinedDB.6)
covMat <- cov(joinedDB.6)
round(covMat, 2)
corelationMat <- cor(joinedDB.6)
round(corelationMat, 2)

# http://www.cookbook-r.com/Graphs/Correlation_matrix/
# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html Do the same, but with colors corresponding
# to value
colorfun <- c("#fef0d9", "#fdcc8a", "#fc8d59", "#e34a33", "#b30000")
plotcorr(corelationMat, col = colorfun)

# http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
colorfun2 <- colorRampPalette(c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494"))
corrplot(corelationMat, method = "number", type = "lower")
corrplot(corelationMat, method = "number", type = "lower", order = "FPC", col = colorfun2(100)) 
