## Stream Generator

## As the app is near real time . We will use the stream_generator function from the sparklyr
## It will generate the csv files randomly from the given file

library(sparklyr)
library(readr)
df <- read_csv("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/new_data.csv")

stream_generate_test(df, path = "/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/",iterations = 10, interval = 3)