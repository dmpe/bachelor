library(rvest)
library(plyr)

hdi <- html('http://hdr.undp.org/en/content/education-index') 
hdi <- hdi %>%
  html_node('.table') %>% 
  html_table(header = T)

hdi <- hdi[1:187,c("Country", "2013")]
hdi <- plyr::rename(hdi, c(`2013` = "Index"))

hdi$Country[hdi$Country == "Korea (Republic of)"] <- "Korea"
hdi$Country[hdi$Country == "Russian Federation"] <- "Russia"
hdi$Index <- as.numeric(hdi$Index)

sapply(hdi, class) 
