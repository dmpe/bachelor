set.seed(5154)
# source("1_RawData/DataFrame.R")
# source("2_Imputation/notUsed/UnsuperRF.R")

################################################
#' https://stackoverflow.com/questions/25966518/daisy-function-warning-message-nas-introduced-by-coercion
#' http://www.researchgate.net/post/What_is_the_proper_imputation_method_for_categorical_missing_value
#' http://www.stat.columbia.edu/~gelman/arm/missing.pdf
#' http://pj.freefaculty.org/guides/Rcourse/multipleImputation/multipleImputation-1-lecture.pdf
#' http://www.stefvanbuuren.nl/mi/docs/Utrecht-15MayCourse%20handout.pdf
#' library(mice)
#' library(VIM)
#' library(R2WinBUGS)
#' library(lattice)
################################################


#' This is non scaled data frame, containing same values in the joinedDB.6$LearningCurveIndex (only) 
#' Replaces LearningCurve data with those from (above) imputed countries.
df.Original.Imputed <- df.Original
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "Nigeria"] <- -2.1
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "South Africa"] <- -1.9
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "Kenya"] <- -1.5
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "Ghana"] <- -1.0
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "Jordan"] <- -0.5
df.Original.Imputed$LearningCurve_Index[df.Original.Imputed$Country == "United Arab Emirates"] <- -0.2

# df.Original.Imputed$LearningCurve_Index <- df.Zscore.Imputed$LearningCurve_Index
df.Original.Imputed <- data.frame(df.Original.Imputed[, -1], row.names = df.Original.Imputed[, 1])

# df.Original.Imputed2 <- df.Original.Imputed
# df.Original.Imputed2$CompletionRate_NonScaled <- df.Original2$Index
# rfunsuper(df.Zscore[2:7]) #' for notUsed/UnsuperRF.R. Load first the source file !
