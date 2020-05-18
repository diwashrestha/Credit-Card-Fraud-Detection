tabItem(tabName = "dashboard"
        ,
        
        fluidRow(column(
          width = 12,
          fluidRow(
            infoBoxOutput("transaction_box"),
            infoBoxOutput("amount_box"),
            infoBoxOutput("alert_box")
          ),
          fluidRow(
            box(collapsible = TRUE,highchartOutput("plot1",
                                height = 500) %>% withSpinner()),
            box(collapsible = TRUE,highchartOutput("plot2",
                                height = 500) %>% withSpinner())
          )
        )))
