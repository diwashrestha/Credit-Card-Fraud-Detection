### Combine data sets

## load library
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(h2o)
library(lubridate)


trans <- read_delim("data/trans.csv", ";", 
                     escape_double = FALSE, trim_ws = TRUE)


## structure of the data
str(trans)

## summary
summary(trans)


trans$bank[is.na(trans$bank)] <- "SELF"
trans$account[is.na(trans$account)] <- "SELF"
trans$k_symbol[is.na(trans$k_symbol)] <- "Missing"
trans$operation[is.na(trans$operation)] <- "Missing"


### missing value

colSums(is.na(trans))

write_csv(trans,"./data/trans.csv")