complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  nobs <- c()
  cnt <- 0
  for (cid in id){
    cnt <- cnt + 1
    data <- getmonitor(cid, directory)
    fdata <- data$Date[!is.na(data$sulfate) & !is.na(data$nitrate)]
    nobs[cnt] <- length(fdata)
  }
  rts <- data.frame(id, nobs)
  rts
  
}