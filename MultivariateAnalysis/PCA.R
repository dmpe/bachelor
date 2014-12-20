library(ellipse)
library(corrplot)
plot(pc.cr)

summary(df)
corelationMat <- cor(df[2:8])

summary(pc.cr <-prcomp(df[2:8],scale=TRUE))
plot(pc.cr)
pc.cr$rotation
pc.cr$sdev
screeplot(pc.cr, type="line")
biplot(pc.cr)


as.matrix(corelationMat)



# http://www.cookbook-r.com/Graphs/Correlation_matrix/
# Do the same, but with colors corresponding to value
colorfun <- colorRamp(c("#CC0000","white","#3366CC"), space="Lab")
plotcorr(corelationMat, col=rgb(colorfun((corelationMat+1)/2), maxColorValue=255))

#http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
corrplot(corelationMat, method = "circle", type = "lower")
corrplot(corelationMat, method = "number",  order = "hclust", addrect = 2)
