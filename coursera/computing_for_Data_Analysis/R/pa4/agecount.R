agecount <- function(age = NULL) {
  ## Check that "age" is non-NULL; else throw error
  ## Read "homicides.txt" data file
  ## Extract ages of victims; ignore records where no age is
  ## given
  ## Return integer containing count of homicides for that age
  if (is.null(age)){
    stop("invalid age")
  }
  homicides <- readLines("homicides.txt")
  reg_str <- paste(as.character(age), " years old", sep="")
  cc <- grep(reg_str, homicides, ignore.case=TRUE)
  return(length(cc))
}
