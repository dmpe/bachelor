library(psych)
library(GPArotation)
# http://www.personality-project.org/r/html/alpha.html or F1

psych::alpha(joinedDB.6[2:7])

coefficientalpha::alpha(joinedDB.6, varphi = 0.01) 
