test_para <- function(para, para_list){
  for (item in para_list){
    if (item == para){
      return(TRUE)
    }
    
  }
  return(FALSE)
}
count <- function(cause = NULL) {
  ## Check that "cause" is non-NULL; else throw error
  ## Check that specific "cause" is allowed; else throw error
  ## Read "homicides.txt" data file
  ## Extract causes of death
  ## Return integer containing count of homicides for that cause
  if ( !test_para(cause, c("asphyxiation", "blunt force", "other", 
                           "shooting", "stabbing", "unknown"))){
    stop("invalid cause")
  }
  homicides <- readLines("homicides.txt")
  reg_str <- paste("<dd>Cause: ", cause, "</dd>", sep="")
  cc <- grep(reg_str, homicides, ignore.case=TRUE)
  return(length(cc))
}