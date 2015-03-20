# https://stats.stackexchange.com/questions/107530/using-cluster-information-in-multiple-imputation
# http://www.rd.dnc.ac.jp/~tunenori/doc/elml_2013_3_20_50062.pdf


rfunsuper <- function(x, iter = 5, ntree = 100) {
    # three different functions Return k-neighbor weighted mean for numeric variables or most weighted frequent factor element
    # for factor variables.
    KWmean <- function(value, weight, k = 10) {
        if (missing(weight)) {
            w <- rep.int(1, length(value))
        } else if (length(weight) != length(value)) {
            stop("'value' and 'weight' must have the same length")
        }
        k <- min(k, length(value))
        if (is.numeric(value)) {
            order.weight <- order(weight, decreasing = T)
            ww <- weight[order.weight]
            vv <- value[order.weight]
            ret <- sum(ww[1:k] * vv[1:k])/sum(ww[1:k])
            
        } else if (is.factor(value)) {
            wgt.sum <- tapply(weight, value, sum)
            # most weighted frequent factor element
            ret <- names(subset(wgt.sum, wgt.sum == max(wgt.sum, na.rm = T)))
        } else {
            stop("'value' is neither numeric nor factor")
        }
        return(ret)
    }
    # Return relative distance between `x.impute' to `x.org'
    relatImpOrg <- function(x.impute, x.org) {
        # x.impute: imputed data x.org: original data
        ncol.x <- length(x.org)
        x.abs.org <- matrix(abs(as.numeric(unlist(x.org))), ncol = ncol.x)
        max.x <- apply(x.abs.org, 2, max)  # for normalization of features size
        # `x.impute' and `x.org' may include factor elements available for only numeric
        if (FALSE) {
            diff.x <- (x.impute - x.org)/max.x  # normalize
            diff.rel <- sum(diff.x^2)/sum((x.org/max.x)^2)
        } else {
            mat.x.impute <- matrix(as.numeric(unlist(x.impute)), ncol = ncol.x)
            mat.x.org <- matrix(as.numeric(unlist(x.org)), ncol = ncol.x)
            max.numx <- as.numeric(unlist(max.x))
            diff.x <- sweep((mat.x.impute - mat.x.org), 2, max.numx, FUN = "/")
            size.org <- sweep(mat.x.org, 2, max.numx, FUN = "/")
            diff.rel <- sum(diff.x^2)/sum(size.org^2)
        }
        cat("diff.rel =", sum(diff.x^2), "/", sum(size.org^2), "=", diff.rel, "\n")
        return(diff.rel)
    }
    # Impute or revise NA elements using the data proximity.
    prox.nafix <- function(na.values, rough.values, x.prox) {
        # na.values: data vector that includes NA; unchanged.  rough.values: rough data vector to be replaced; NAs cannot include.
        # x.prox: data proximity matrix; each element is positive and <= 1.
        if (length(na.values) != length(rough.values)) {
            stop("'na.values' and 'rough.values' must have the same length")
        } else if (length(rough.values) != ncol(x.prox)) {
            stop("'rough.values' and 'x.prox' size incorrect")
        }
        # NA imputation ONLY for NA data
        na.list <- which(is.na(na.values))
        if (length(na.list) == 0) {
            # no NAs
            return(rough.values)
        }
        replaced.vales <- rough.values
        for (i in 1:length(na.list)) {
            j <- na.list[i]
            x.prox[j, j] <- 0  # ignore the weight of the data to be imputed.
            replaced.vales[j] <- KWmean(rough.values, x.prox[, j])
        }
        return(replaced.vales)
    }
    require(randomForest)
    x.roughfixed <- na.roughfix(x)
    
    # For numeric variables, NAs are replaced with column medians.  For factor variables, NAs are replaced with the most
    # frequent levels (breaking ties at random).
    rf.impute <- x
    while (iter) {
        x.rf <- randomForest(x.roughfixed, ntree = ntree)
        # randomForest implements Breiman's random forest algorithm
        x.prox <- x.rf$proximity
        # a matrix of proximity measures among the input (based on the frequency that pairs of data points are in the same terminal
        # nodes).
        for (i in 1:ncol(x)) {
            rf.impute[, i] <- prox.nafix(x[, i], x.roughfixed[, i], x.prox)
        }
        diff.rel <- relatImpOrg(rf.impute, x.roughfixed)
        if (diff.rel < 1e-05) {
            break
        } else {
            x.roughfixed <- rf.impute
            iter <- iter - 1
        }
    }
    print(x.rf)
    return(rf.impute)
} 
