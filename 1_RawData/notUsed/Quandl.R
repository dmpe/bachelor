library("Quandl")

Quandl.auth("GgnxpyUBXHsyQxqp67bY")
Quandl.auth("Dqdm3sK2zySySqJPLzyK")

# be aware it takes 1 !!! call per 1 request
# 2 previos max

# PaidDataOnHG = Quandl("SGE/HKGMPMI", trim_start="2014-03-01", trim_end="2015-03-01", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnHG

# PaidDataOnSK = Quandl("SGE/KORMPMI", trim_start="2014-03-01", trim_end="2015-03-01", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnSK
#
# PaidDataOnSG = Quandl("SGE/SGPMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="Dqdm3sK2zySySqJPLzyK")
PaidDataOnSG

# PaidDataOnTW = Quandl("SGE/TWNMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="Dqdm3sK2zySySqJPLzyK")
PaidDataOnTW


# We take the mean over the whole year

meanPMIHG = mean(PaidDataOnHG$Value)
meanPMISK = mean(PaidDataOnSK$Value)
meanPMISG = mean(PaidDataOnSG$Value)
meanPMITW = mean(PaidDataOnTW$Value)

# Create data frame

PMIData = data.frame(PMI=c(meanPMIHG, meanPMISG, meanPMISK, meanPMITW))
# View(PMIData)
