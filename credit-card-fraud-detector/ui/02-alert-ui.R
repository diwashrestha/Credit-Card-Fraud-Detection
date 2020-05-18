tabItem(tabName = "alert"
        ,
        
        fluidRow(column(
          width = 12,
          fluidRow(
            infoBoxOutput("a_transaction_box", width = 3),
            infoBoxOutput("a_amount_box", width = 3),
            infoBoxOutput("a_fraud_box", width = 3),
            infoBoxOutput("a_genuine_box", width = 3)
            
          ),
          fluidRow(
            box(DTOutput("datatable",
                         height = 500) %>%  withSpinner()),
            box(plotOutput("limeplot",
                           height = 500) %>% withSpinner())
          )
        )))
