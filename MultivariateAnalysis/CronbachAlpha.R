
library(psych)
library(GPArotation)
# http://www.personality-project.org/r/html/alpha.html or F1
psych::alpha(df[2:8])

coefficientalpha::alpha(df[2:8], varphi=.01)
