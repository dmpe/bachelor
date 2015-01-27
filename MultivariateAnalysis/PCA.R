library(ellipse)


summary(pc.cr <-prcomp(na.omit(joinedDB.8[2:7]), scale=TRUE))
plot(pc.cr)
pc.cr$rotation
pc.cr$sdev
screeplot(pc.cr, type="line")
biplot(pc.cr, scale = 1, pc.biplot = FALSE)

# eigen not possible due to non squer matrix
