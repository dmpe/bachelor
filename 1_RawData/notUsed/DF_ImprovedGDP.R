library(stringr)
library(plyr)
library(dplyr)

# Sources: https://stackoverflow.com/questions/24954624/error-in-download-file-no-such-file-or-directory

# gdp projections from 2014 IMF

# check if exists, if not -> download through curl and store in a folder RawData
if (!file.exists("RawData/DataSources/GDPperCapitaIMF.txt")) {
    download.file(, destfile = "./RawData/DataSources/GDPperCapitaIMF.txt", method = "curl")
} else {
    message("The file is already in the RawData folder")
}

GDPperCapitaIMF <- read.delim("/srv/shiny-server/RealBachelor/RawData/DataSources/GDPperCapitaIMF.txt")

# what kind of data type is X2014 http://www.statmethods.net/input/datatypes.html
class(GDPperCapitaIMF$X2014)

# delete comma , from X2014 column strings and replace it with nothing
GDPperCapitaIMF$X2014 = str_replace_all(GDPperCapitaIMF$X2014, ",", "")

# View(GDPperCapitaIMF) delete 190th row from data frame
GDPperCapitaIMF = GDPperCapitaIMF[-187, ]

# convert $ chars to numeric format
GDPperCapitaIMF$X2014 = as.numeric(GDPperCapitaIMF$X2014)

# rename X2014 in GDPinDollars
names(GDPperCapitaIMF)[names(GDPperCapitaIMF) == "X2014"] <- "GDPinDollars"


# store everything in TigersGDP data frame by subsetting only two columns
# https://stat.ethz.ch/pipermail/r-help/2011-April/274149.html
TigersGDP = subset(GDPperCapitaIMF, Country %in% c("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", 
    "Germany", "Switzerland", "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", 
    "Australia", "South Africa", "Kenya", "Finland", "Canada", "Israel", "New Zealand"), select = c(Country, GDPinDollars))







 
