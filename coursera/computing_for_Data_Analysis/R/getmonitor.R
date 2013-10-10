getmonitor <- function(id, directory, summarize = FALSE) {
  sid <- as.character(id)
  if (nchar(sid)==1){
    sid = paste("00", sid, sep="")
  }else {
    if (nchar(sid)==2){
      sid = paste("0", sid, sep="")
    }
  }
  if (substr(directory, nchar(directory), nchar(directory)) != "/"){
    directory <- paste(directory, "/", sep="")
  }
  data_path <- paste(directory, sid ,".csv", sep="")
  data <- read.table(data_path, header=TRUE, sep=",")
  if (summarize){
       summary(data)
  }
  data
}