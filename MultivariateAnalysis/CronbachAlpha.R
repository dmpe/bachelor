
library(psych)
library(GPArotation)
# http://www.personality-project.org/r/html/alpha.html or F1
psych::alpha(joinedDB.8[2:6])

coefficientalpha::alpha(joinedDB.8[2:6], varphi=.01)
