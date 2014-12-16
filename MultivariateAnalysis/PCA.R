plot(pc.cr)

summary(df)
cor(df[2:8])

summary(pc.cr <-prcomp(df[2:8],scale=TRUE))
plot(pc.cr)
pc.cr$rotation
screeplot(pc.cr, type="line")
biplot(pc.cr)
pc.cr$scores
