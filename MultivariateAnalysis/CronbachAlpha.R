if (!require(psych)) install.packages('psych')
if (!require(GPArotation)) install.packages('GPArotation')
library(psych)
library(GPArotation)
# http://www.personality-project.org/r/html/alpha.html or F1
alpha(df)
