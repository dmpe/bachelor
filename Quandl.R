library("Quandl")

Quandl.auth("GgnxpyUBXHsyQxqp67bY")
# be aware it takes 1 !!! call per 1 request

#PaidDataOnHG = Quandl("SGE/HKGMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnHG
#PaidDataOnSK = Quandl("SGE/KORMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnSK
#PaidDataOnSG = Quandl("SGE/SGPMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnSG
#PaidDataOnTW = Quandl("SGE/TWNMPMI", trim_start="2014-05-01", trim_end="2014-10-31", authcode="GgnxpyUBXHsyQxqp67bY")
PaidDataOnTW


# We take the mean (avarage)

meanPMIHG = mean(PaidDataOnHG$Value)
meanPMISK = mean(PaidDataOnSK$Value)
meanPMISG = mean(PaidDataOnSG$Value)
meanPMITW = mean(PaidDataOnTW$Value)


PMIData = data.frame(PMI=c(meanPMIHG, meanPMISG, meanPMISK, meanPMITW))
PMIData
