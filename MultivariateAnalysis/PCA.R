library(ellipse)
# http://www.r-bloggers.com/pca-and-k-means-clustering-of-delta-aircraft/

summary(pc.cr <-prcomp(joinedDB.6), scale=TRUE))
plot(pc.cr)
pc.cr$rotation
pc.cr$sdev
screeplot(pc.cr, type="line")
biplot(pc.cr, scale = 1, pc.biplot = FALSE)

# eigen not possible due to non squer matrix
pc <- princomp(joinedDB.6)
plot(pc)
summary(pc)
loadings(pc)
plot(pc, type='l')
