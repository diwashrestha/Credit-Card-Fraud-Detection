 
demo_data <- fread("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/data/test_data.csv",fill = TRUE)

## load h2o model
demo_model <- h2o.loadModel("/home/diwash/projeckt/credit_card_feaud/model/GBM_model_R_1558482610633_2")

## manipulate data 
h2oDemodata <- select(demo_data,-Time_hr)
h2oData <- as.h2o(h2oDemodata)

h2o.predict(demo_model,h2oData) %>% as.data.table()
final_data <- bind_cols(demo_data,h2o.predict(demo_model,h2oData) %>% as.data.table())

h2o.predict_contributions(demo_model,h2oData)
