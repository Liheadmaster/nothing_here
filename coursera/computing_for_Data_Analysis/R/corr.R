corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  rts <- c()
  mode(rts) <- "numeric"
  cases <- complete(directory)
  filt_id <- cases$id[cases$nobs > threshold]
  for (id in filt_id){
    all_data <- getmonitor(id, directory)
    filt_sul <- all_data$sulfate[!is.na(all_data$sulfate) & !is.na(all_data$nitrate)]
    filt_nit <- all_data$nitrate[!is.na(all_data$sulfate) & !is.na(all_data$nitrate)]
    rts <- c(rts, c(cor(filt_sul, filt_nit)))
  }
  rts
}
