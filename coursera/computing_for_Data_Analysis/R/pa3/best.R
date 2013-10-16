best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  all_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  row_count <- length(all_data[,1])
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
  ta_h <- NA
  ta_value <- NA
  ta_state <- NA
  for (i in 1:row_count){
    items <- all_data[i,]
    tmp_value <- as.numeric(items[ta])
    tmp_h <- as.character(items[2])
    tmp_state <- as.character(items[7])
    
    if (tmp_state == state & !is.na(tmp_value)){
      ta_state <- state
      if (is.na(ta_value) | tmp_value < ta_value ){
        ta_value <- tmp_value
        ta_h <- tmp_h
        
      }else{
        if (tmp_value == ta_value){
          ta_h <- min(c(ta_h, tmp_h))
        }
      }
    }
  }
    if (is.na(ta_state)){
      stop("invalid state")
    }else{
      ta_h
    }
  }
}
