library(stringr)
# library(plyr)
library(dplyr)
library(ggplot2)
# library(reshape2)


# Sources: https://stackoverflow.com/questions/24954624/error-in-download-file-no-such-file-or-directory

# gdp projections from 2014 IMF


GDPperCapitaIMF <- read.delim("1_RawData/DataSources/GDPIMF.txt")

# what kind of data type is X2014 http://www.statmethods.net/input/datatypes.html
# class(GDPperCapitaIMF$X2014)

# delete comma , from X2014 column strings and replace it with nothing
GDPperCapitaIMF$X2015 = str_replace_all(GDPperCapitaIMF$X2015, ",", "")

# View(GDPperCapitaIMF) delete 190th row from data frame
GDPperCapitaIMF = GDPperCapitaIMF[-188, ]

# convert $ chars to numeric format
GDPperCapitaIMF$X2015 = as.numeric(GDPperCapitaIMF$X2015)

# rename X2014 in GDPinDollars
names(GDPperCapitaIMF)[names(GDPperCapitaIMF) == "X2015"] <- "GDPinDollars"


# store everything in TigersGDP data frame by subsetting only two columns
# https://stat.ethz.ch/pipermail/r-help/2011-April/274149.html
TigersGDP = subset(GDPperCapitaIMF, Country %in% c("Korea", "Singapore", "Japan", "Chile", "Czech Republic", "Nigeria", "China", "Germany", "Switzerland", 
                                                   "Mexico", "Jordan", "Brazil", "Russia", "United States", "United Kingdom", "United Arab Emirates", "Australia", "South Africa", 
                                                   "Kenya", "Finland", "Canada", "Israel", "New Zealand", "France", "Hungary", "Thailand", "Indonesia", "Ghana", "Colombia", "Turkey"), select = c(Country, GDPinDollars))



gdpTiger <- dplyr::full_join(TigersGDP, df.Original.MM.FA, by = "Country")
sapply(gdpTiger, class)

# gdpTiger.melted <- melt(gdpTiger, id = "Country")  # convert to long format

f18 <- ggplot(data=gdpTiger, aes(x = Value, y = GDPinDollars, label=Country))
f18 <- f18 + geom_point() + geom_text(aes(label=Country), hjust=0, vjust=0) # stat_smooth(method = "lm")
f18 <- f18 + coord_cartesian(ylim = c(0, 85000)) + scale_y_continuous(breaks = seq(0, 85000, 5000))
f18 <- f18 + coord_cartesian(xlim = c(35, 90)) + scale_x_continuous(breaks = seq(35, 90, 2))
f18 <- f18 + ggtitle("Relationship between GDP PPP and Attractiveness Index") + ylab("GDP per Capita (PPP $), 2015") + xlab("Attractiveness Index 35-90")
f18

cor(gdpTiger$Value, gdpTiger$GDPinDollars)
 
