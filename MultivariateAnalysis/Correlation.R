# Correlation

library(corrplot)


summary(joinedDB.8)
corelationMat <- cor(joinedDB.8[2:7], use="complete.obs")
corelationMat <- as.matrix(corelationMat)


# http://www.cookbook-r.com/Graphs/Correlation_matrix/
# Do the same, but with colors corresponding to value
colorfun <- colorRamp(c("#CC0000","white","#3366CC"), space="Lab")
plotcorr(corelationMat, col=rgb(colorfun((corelationMat+1)/2), maxColorValue=255))

#http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
corrplot(corelationMat, method = "circle", type = "lower")
corrplot(corelationMat, method = "number",  order = "hclust", addrect = 3)














