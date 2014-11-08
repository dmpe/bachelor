gdpPerCapita = c(78762,52984,33791,41539)
edb =c(1,3,5,19)
pst = c(2,3,5,4)
pupilPerTeachers =c(13.2,13.5,16,18)
# Quandl

avarageClassSize = c(35.9,31,38.6,40)
# prvni vec k reseni
expenditurePerStudent = c(23.4,17.3,23.6, NA )

df = data.frame(gdpPerCapita, edb, pst, pupilPerTeachers, avarageClassSize, expenditurePerStudent)
df