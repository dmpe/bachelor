library(corrplot)
library(ellipse)

set.seed(5154)

################################
#' http://www.cookbook-r.com/Graphs/Correlation_matrix/
#' http://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html 
################################

names(df.Original.MinMax) <- c("Unemployment", "Freedom_Index", "WEF_Score", "LearningCurve_Index", "HDIEducat_Index", "H_Index")
corelationMat2 <- cor(df.Original.MinMax)

colorfun2 <- colorRampPalette(c("#ffffcc", "#a1dab4", "#41b6c4", "#2c7fb8", "#253494"))
corrplot(corelationMat2, method = "number", type = "lower", order = "FPC", col = colorfun2(100)) 
