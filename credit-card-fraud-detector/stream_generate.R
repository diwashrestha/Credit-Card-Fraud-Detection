## this script saves data as a csv file in 15 second

library(dplyr)
library(readr)
library(data.table)

data <-
  read_csv(
    "/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/data/test_data.csv"
  )

#i = 0.05
i = 1
while (i <= 600) {
  #temp=sample_frac(data,i)
  temp = head(data, i * sample(85:100, 1))
  i = i + sample(25:40, 1)
  #  write.csv(temp, paste0("stream", gsub("[^0-9]","",Sys.time()),".csv"),
  fwrite(temp, "stream.csv", row.names = FALSE)
  Sys.sleep(15) # Suspend execution of R expressions. The time interval to suspend execution for, in seconds.
  
}
