rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  rdata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  all_data <- rdata[rdata[,7]==state,]
  row_count <- length(all_data[,1])
  if (row_count==0){
    stop("invalid state")
  }
  ta<-NA
  if (outcome=="heart attack"){
    ta <- 11
  }
  if (outcome=="heart failure"){
    ta <- 17
  }
  if (outcome=="pneumonia"){
    ta <- 23
  }
  if (is.na(ta)){
    stop("invalid outcome")
  }else{
      all_data[, ta] <- as.numeric(all_data[, ta])
      all_data <- all_data[!is.na(all_data[,ta]),]
      row_count <- length(all_data[,1])
      all_data <- all_data[order(all_data[,ta], all_data[,2]),]
      if (num=="best"){
        return(as.character(all_data[1,][2]))
      }
      if (num=="worst"){
        return(as.character(all_data[row_count,][2]))
      }
      num <- as.numeric(num)
      if (is.na(num)){
        stop("invalid num")
      }
     
      return(as.character(all_data[num,][2]))
  }
}
