# Define server logic
# Server will work on the data reading,data passing to model and passing data to ui section for visualization

IsThereNewFile <-
  function() {
    #  cheap function whose values over time will be tested for equality;
    #  inequality indicates that the underlying value has changed and needs to be
    #  invalidated and re-read using valueFunc
    filenames <- list.files(pattern = "*.csv", full.names = TRUE)
    length(filenames)
  }

ReadAllData <-
  function() {
    # A function that calculates the underlying value
    filenames <- list.files(pattern = "*.csv", full.names = TRUE)
    fread(filenames[length(filenames)])
  }

ReadData <- function(file) {
  ## Function that read file
  fread(file, fill = TRUE)
}

shinyServer(server <- function(input, output, session) {
  #  values <- reactiveValues()
  #  values$data <-  read_csv("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/data/data.csv")

  ## read the files in 3 second difference
  # sampled_data <- reactivePoll(1000, session, IsThereNewFile, ReadAllData)
  sampled_data <-
    reactiveFileReader(15000, session, "stream.csv", ReadData)

  predict_fraud <- reactive({
    data <- sampled_data() %>% select(-Time_hr)
    h2odata <- as.h2o(data)
    # h2o.predict(demo_model,h2oData) %>% as.data.table()
    prediction <-
      bind_cols(data, h2o.predict(model, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudrf <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    # h2o.predict(demo_model,h2oData) %>% as.data.table()
    prediction <-
      bind_cols(data, h2o.predict(modelrf, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudxg <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    # h2o.predict(demo_model,h2oData) %>% as.data.table()
    prediction <-
      bind_cols(data, h2o.predict(modelxg, h2odata) %>% as.data.frame())
    return(prediction)
  })

  predict_fraudgb <- reactive({
    data <- sampled_data()
    h2odata <- as.h2o(data)
    # h2o.predict(demo_model,h2oData) %>% as.data.table()
    prediction <-
      bind_cols(data, h2o.predict(modelgb, h2odata) %>% as.data.frame())
    return(prediction)
  })
  #  real_data <- reactivePoll(3000, session, ReadData)

  source("server/01-dashboard-srv.R", local = TRUE)
  source("server/02-alert-srv.R", local = TRUE)
  source("server/02-xgalert-srv.R", local = TRUE)
  source("server/02-gbmalert-srv.R", local = TRUE)
  source("server/02-rfalert-srv.R", local = TRUE)
})
