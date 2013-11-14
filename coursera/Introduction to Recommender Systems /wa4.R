ave <- function(x) {
  v <- !is.na(x)
  return(sum(as.numeric(x[v]))/sum(v))
}

unweight_score <- function(x, y) {
  cc <- complete.cases(x, y)
  cx <- x[cc] - ave(x[cc])
  cy <- y[cc] - ave(y[cc])
  sum(cx*cy) / ( sqrt(sum(cx*cx)) * sqrt(sum(cy*cy)) )
}

cal_top <- function(uid){
  data <- read.table("wa4.csv", head=TRUE, sep=",")
  users <- names(data)[2:26]
  corr_user <- vector("numeric", 25)
  names(corr_user) <- users
  for (user in users){
    corr_user[user] <- unweight_score(data[[user]],data[[uid]])
  }
  rts <- sort(corr_user, TRUE)
  top_f <- rts[2:6]
  top_names <- names(top_f)
  top_rave <- c(ave(data[[top_names[1]]]),
                ave(data[[top_names[2]]]),
                ave(data[[top_names[3]]]),
                ave(data[[top_names[4]]]),
                ave(data[[top_names[5]]])
                    )
  top_data <- data.frame(data$name, data[names(top_f)])
  movies <- top_data[,1]
  rec_movie <- vector("numeric", 100)
  names(rec_movie) <- movies
  
  ave_uid <- ave(data[[uid]])
  print(ave_uid)
  for (i in 1:length(movies)){
    movie <- top_data[i,][[1]]
    row_data <- as.vector(top_data[i,2:6], "numeric") - top_rave
    cc_tmp <- complete.cases(row_data, top_f)
    upsum <- sum(row_data[cc_tmp] * top_f[cc_tmp])
    downsum <- sum(top_f[cc_tmp])
    rec_movie[i] <- ave_uid + upsum/downsum
  }
  
  rec_movie <- sort(rec_movie, TRUE)
  return(rec_movie[1:3])
}
