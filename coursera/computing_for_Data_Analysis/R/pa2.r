getmonitor <- function(id, directory, summarize = FALSE) {
  data_path <- paste(directory, id ,".csv", sep="")
  data <- read.table(data_path, header=TRUE, sep=",")
  if (summarize){
       summarize(data)
  }else{
      data
  }
}