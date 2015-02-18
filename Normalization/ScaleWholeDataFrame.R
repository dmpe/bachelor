

source("RawData/DataFrame.R")
source("Imputation/MICE_Imputation.R")


scaledOnlyThoseNeeded <- scale(joinedDB.6[, c("Unemployment", "Freedom_Index", "WEF_Score", "CompletionRate", "Ranking_HIndex")])


















