# Source: https://gist.github.com/williamvoor/5573059

ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) {
    install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.rstudio.com/")
  }
  sapply(pkg, require, character.only = TRUE)
}

# Here are packages which I have used. Some others will requriered to be installed manually, if running code in the comments !
# Installation may take very long time (> 15 minutes) !
# PS: Not all are listed here. 
packages <- c("Quandl", "stringr", "ggplot2", "fpc", "plyr", "reshape2", "RColorBrewer", "scales", "grid", "mclust", "psych", 
              "cluster", "dplyr", "rJava", "rvest", "corrplot", "xlsx", "RCurl", "Rcpp", "data.table", "coda", "NbClust", "clustrd", 
              "flexclust", "ellipse", "pmr", "Compind", "lattice", "gridExtra", "grid")
ipak(packages)

# Because rJava may print error messages (during or after installation), it is still necessary load it correctly. For
# solutions look here:
# http://www.r-statistics.com/2012/08/how-to-load-the-rjava-package-after-the-error-java_home-cannot-be-determined-from-the-registry/
# https://stackoverflow.com/questions/3311940/r-rjava-package-install-failing

# Also see readme. Or (it may help) use just < R CMD javareconf >

# Format R scripts everything
# tidy_dir(getwd(), recursive = TRUE) 

# Get the number of packages installed
installedPacks <- installed.packages(priority = "NA", noCache = TRUE)
