#Some small analysis using Factor analysis
library(psych)
library(GPArotation)
source("DataFrame.R")
# http://rtutorialseries.blogspot.de/2011/10/r-tutorial-series-exploratory-factor.html
novydf = df[,3:4]

#class(df)

corelation = cor(novydf)
solution <- fa(r = corelation, nfactors = 2, rotate = "oblimin", fm = "minres", SMC=FALSE) 
solution
scree(corelation)

