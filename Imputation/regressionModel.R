
library(VIM)
library(Amelia)
# https://www.amstat.org/sections/srms/webinarfiles/ModernMethodWebinarMay2012.pdf
# http://galton.uchicago.edu/~eichler/stat24600/Admin/MissingDataReview.pdf

# regress
dqw <- lm(joinedDB.5$Ranking_LearningCurve ~ joinedDB.5$Ranking_HIndex + joinedDB.5$CompletionRate)
summary(dqw)

# https://stats.stackexchange.com/questions/100841/imputation-by-regression-in-r
ads <- regressionImp(Ranking_LearningCurve + Rae ~ Ranking_HIndex + CompletionRate, data = joinedDB.5)


aregImpute(joinedDB.4$Ranking_LearningCurve ~ joinedDB.4$Ranking_WEF + joinedDB.4$CompletionRate)
names(joinedDB.5)

mi.binary(joinedDB.5$Ranking_LearningCurve ~ joinedDB.5$Ranking_HIndex + joinedDB.5$CompletionRate, data = joinedDB.5)
