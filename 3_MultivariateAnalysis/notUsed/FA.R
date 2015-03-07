#Some small analysis using Factor analysis
library(psych)
library(GPArotation)
source("http://www.tcnj.edu/~ruscio/EFA%20Comparison%20Data.R")
# http://rtutorialseries.blogspot.de/2011/10/r-tutorial-series-exploratory-factor.html

solution <- fa(r = corelationMat, nfactors = 6, rotate = "oblimin", fm = "minres", SMC=FALSE) 
solution

# http://personality-project.org/r/vss.html
# my.vss <- VSS(na.omit(joinedDB.8[2:7]),n=6, rotate="none",diagonal=FALSE)
# VSS.plot(my.vss)
VSS.scree(corelationMat, main ="scree plot")
#https://stats.stackexchange.com/questions/32669/vss-criterion-for-the-number-of-factors-in-rs-psych-package
#https://stats.stackexchange.com/questions/31948/looking-for-a-step-through-an-example-of-a-factor-analysis-on-dichotomous-data/32136#32136
faPCdirect <- fa.poly(corelationMat, nfactors=2, rotate="varimax")    # polychoric FA
factor.plot(faPCdirect$fa, cut=0.5)
fa.diagram(faPCdirect)


EFA.Comp.Data(Data=na.omit(joinedDB.8[2:7]), F.Max=6, Graph=T)
vss(na.omit(joinedDB.8[2:7]), n=2)
fa.parallel(na.omit(joinedDB.8[2:7]))







ev <- eigen(cor(joinedDB.6)) # get eigenvalues
ap <- parallel(subject=nrow(joinedDB.6),var=ncol(joinedDB.6),rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
nS$Components
nS$Analysis
plotnScree(nS) 








