# This file loads necessary R-Scripts, adds additional data from rankings 
# and finally creates data.frame

# From R Documentation
# source() causes R to accept its input from the named file or URL or connection.
# Input is read and parsed from that file until the end of the file is reached, then the parsed
# expressions are evaluated sequentially in the chosen environment. 
source("GDPdata.R")
source("Quandl.R")

# Following data have structure corresponding to SG, HK, SK and Taiwan - in this order
# For their sources see my thesis, and corresponding table


# ranking position
EasyBusiness = c(1,3,5,19)
Pisa = c(2,3,5,4)

PupilPerTeachersRatio = c(13.2,13.5,16,18)
AvarageClassSize = c(35.9,31,38.6,40)
ExpenditurePerStudent = c(23.4,17.3,23.6,4.62)


# wide format
df = data.frame(TigersGDP, EasyBusiness, Pisa, PupilPerTeachersRatio, 
                AvarageClassSize, ExpenditurePerStudent, PMIData)

rownames(df) = 1:nrow(df)
df

# Check that all var. in df are numeric
# http://stackoverflow.com/a/10661161
lapply(df, class)


