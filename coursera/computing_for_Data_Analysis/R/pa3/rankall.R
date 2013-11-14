rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
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
  }
  
  rdata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  all_state <- levels(factor(rdata[,7]))
  hospital <- c() 
  state <- c()
  count <- 0
  for (tmp_state in all_state){
    count <- count + 1
    state[count] <- tmp_state
    all_data <- rdata[rdata[,7]==tmp_state,]
    row_count <- length(all_data[,1])
  
  
    all_data[, ta] <- as.numeric(all_data[, ta])
    all_data <- all_data[!is.na(all_data[,ta]),]
    row_count <- length(all_data[,1])
    all_data <- all_data[order(all_data[,ta], all_data[,2]),]
    if (num=="best"){
      hospital[count] <- as.character(all_data[1,][2])
      next
    }
    if (num=="worst"){
      hospital[count] <- as.character(all_data[row_count,][2])
      next
    }
    num <- as.numeric(num)
    if (is.na(num)){
      stop("invalid num")
    }
    
    hospital[count] <- as.character(all_data[num,][2])
  
  }
  rts <- data.frame(hospital, state)
  rts
}
