# This file loads necessary R-Scripts, adds additional data from rankings and finally creates data.frame


source("GDPdata.R")
source("Quandl.R")

edb =c(1,3,5,19)
pst = c(2,3,5,4)
pupilPerTeachers =c(13.2,13.5,16,18)

avarageClassSize = c(35.9,31,38.6,40)

# prvni vec k reseni
expenditurePerStudent = c(23.4,17.3,23.6, NA )

df = data.frame(TigersGDP, edb, pst, pupilPerTeachers, avarageClassSize, expenditurePerStudent)
df
