### Combine data sets

## load library
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(h2o)
library(lubridate)
library(stringi)


######################### CLIENT DATA CLEANING ########################
#######################################################################

## Client dataset has details about the client's identity. The birthdate has gender data
## also which need to be extracted to find gender

client <- read_delim("data/raw/client.asc",
  ";",
  escape_double = FALSE, trim_ws = TRUE
)

client$birth_number <- as.character(client$birth_number)

## substr selects the value from the given postion like 3rd and 4th
client$month <- substr(client$birth_number, 3, 4)
client$month <- as.numeric(client$month)

## female client has months value with 50 added. we can find female client usng month
client <- mutate(client, female = (month - 50 >= 0))
client$month[client$female == TRUE] <- client$month[client$female == TRUE] - 50
client$year <- substr(client$birth_number, 1, 2)
client$day <- substr(client$birth_number, 5, 6)



## concat numbers before the dates
client$month <- stri_pad_left(client$month, 2, pad = "0")
client$year <- stri_pad_left(client$year, 3, pad = "9")
client$year <- stri_pad_left(client$year, 4, pad = "1")

client <- unite(client, birth_date, year, month, day, sep = "", remove = FALSE)

## convert the value of the new_date to date form
client$birth_date <- ymd(client$birth_date)

client <- select(client, client_id, district_id, birth_date, female)

write_csv(client, "./data/clean/client.csv")


######################### ACCOUNT DATA CLEANING ##########################
##########################################################################

account <- read_delim("data/raw/account.asc",
  ";",
  escape_double = FALSE, trim_ws = TRUE
)

## account transformation
account$year <- substr(account$date, 1, 2)
account$month <- substr(account$date, 3, 4)
account$day <- substr(account$date, 5, 6)

account$year <- stri_pad_left(account$year, 3, pad = "9")
account$year <- stri_pad_left(account$year, 4, pad = "1")

## concat year,month and day
account <- unite(account, account_date, year, month, day, sep = "", remove = FALSE)
account$account_date <- ymd(account$account_date)

account <- select(account, account_id, district_id, frequency, account_date)
write_csv(account, "./data/clean/account.csv")


########## TRANSACTION DATA CLEANING #####################
##########################################################

trans <- read_delim("data/raw/trans.asc",
  ";",
  escape_double = FALSE, trim_ws = TRUE
)

## in transaction data the type columns gives credit or debit transaction. We only want credit transactions.
new_trans <- filter(trans, type == "PRIJEM")

## transaction dataset has huge number of missing values.The k_symbol,bank,account has more than 75% missing value.

new_trans$date <- stri_pad_left(new_trans$date, 7, pad = "9")
new_trans$date <- stri_pad_left(new_trans$date, 8, pad = "1")
new_trans$date <- ymd(new_trans$date)

new_trans$trans_date <- new_trans$date

new_trans <- select(new_trans, -date, -type)
write_csv(new_trans, "./data/clean/transaction.csv")


################### CREDIT CARD DATA CLEANING #######################
#####################################################################
card <- read_delim("data/raw/card.asc", ";",
  escape_double = FALSE, trim_ws = TRUE
)

card$issued_date <- substr(card$issued, 1, 6)
card$issued_date <- stri_pad_left(card$issued_date, 7, pad = "9")
card$issued_date <- stri_pad_left(card$issued_date, 8, pad = "1")
card$issued_date <- ymd(card$issued_date)

card <- select(card, -issued)

write_csv(card, "./data/clean/card.csv")


##################### CONCAT DISPOSITION ,CREDIT CARD,ACCOUNT,CLIENT,TRANSACTION DATA ###############################
#####################################################################################################################

disp <- read_delim("data/raw/disp.asc", ";",
  escape_double = FALSE, trim_ws = TRUE
)

## join new_trans and account on basis of account_id
## join disp and client on basis of client_id
## join new_disp and new_account_trans by account_id
## join card and new_disp data by disp_id

new_account_trans <- inner_join(new_trans, account, by = "account_id")
new_disp <- inner_join(disp, client, by = "client_id")
new_disp <- inner_join(new_disp, new_account_trans, by = "account_id")
new_disp <- inner_join(new_disp, card, by = "disp_id")

### the final data has 82999 observation or rows and 21 variables which need to be more clean and engineered.

write_csv(new_disp, "./data/clean/final_trans.csv")