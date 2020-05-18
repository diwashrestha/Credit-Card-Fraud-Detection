# importing pandas package 
import pandas as pd 
  
# making data frame from csv file  
data = pd.read_csv("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/data/new_data.csv") 
  

i = 0.01
while i < 1:
  df = data.sample(frac = i)
  df.to_csv('/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/data/stream.csv',index=False)
  i+= 0.02
  time.sleep(10)
