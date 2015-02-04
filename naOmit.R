summary(na.omit(joinedDB.8))
summary(joinedDB.8)

require(graphics)
DF <- data.frame(x = c(1, 2, 3), y = c(0, 10, NA))
summary(na.omit(DF))
summary(DF)
