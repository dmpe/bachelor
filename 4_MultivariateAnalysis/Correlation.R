library(corrplot)
library(ellipse)

set.seed(5154)

################################
#' http://www.cookbook-r.com/Graphs/Correlation_matrix/
#' http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html 
################################

names(df.Original.MinMax) <- c("Unemployment", "Freedom_Index", "WEF_Score", "LearningCurve_Index", "HDIEducat_Index", "H_Index")
# summary(df.Zscore.Imputed)
# covMat <- cov(df.Zscore.Imputed)
# round(covMat, 2) df.Original.MinMax
# corelationMat <- cor(df.Zscore.Imputed)
corelationMat2 <- cor(df.Original.MinMax)

# round(corelationMat, 2)


#' Do the same, but with colors corresponding to value
#' colorfun <- c("#fef0d9", "#fdcc8a", "#fc8d59", "#e34a33", "#b30000")
#' plotcorr(corelationMat, col = colorfun)

colorfun2 <- colorRampPalette(c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494"))
corrplot(corelationMat2, method = "number", type = "lower", order = "FPC", col = colorfun2(100)) 
