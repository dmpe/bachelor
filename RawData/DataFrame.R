# This file loads necessary R-Scripts, adds additional data from rankings 
# and finally creates data.frame


source("GDPdata.R")
source("Quandl.R")

EDB = c(1,3,5,19)
PST = c(2,3,5,4)
PupilPerTeachersRatio = c(13.2,13.5,16,18)
AvarageClassSize = c(35.9,31,38.6,40)

# muzu to ale illustrovat 
ExpenditurePerStudentInGDP = c(23.4,17.3,23.6,4.62)

#wide format
df = data.frame(TigersGDP, EDB, PST, PupilPerTeachersRatio, 
                AvarageClassSize, ExpenditurePerStudentInGDP, PMIData)
rownames(df) = 1:nrow(df)

df

# Check that all are numeric
# http://stackoverflow.com/a/10661161
lapply(df, class)


