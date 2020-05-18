IsThereNewFile=function(){  #  cheap function whose values over time will be tested for equality;
  #  inequality indicates that the underlying value has changed and needs to be 
  #  invalidated and re-read using valueFunc
  filenames <- list.files(pattern="*.csv", full.names=TRUE)
  length(filenames)
}
ReadAllData=function(){ # A function that calculates the underlying value
  filenames <- list.files(pattern="*.csv", full.names=TRUE)
  read_csv(filenames[length(filenames)])
}
