# Source: https://gist.github.com/williamvoor/5573059

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE, repos='http://cran.rstudio.com/')
    sapply(pkg, require, character.only = TRUE)
} 

# usage
packages <- c("Quandl", "stringr", "ggplot2", "fpc", "plyr", "reshape2", 
              "RColorBrewer", "scales", "grid", "mclust","psych","GPArotation", "cluster")
ipak(packages) 
