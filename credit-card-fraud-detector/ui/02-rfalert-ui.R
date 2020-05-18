tabItem(
  tabName =
    "rfalert",

  fluidRow(column(
    width = 12,
    fluidRow(
      infoBoxOutput("rf_transaction_box", width = 3),
      infoBoxOutput("rf_amount_box", width = 3),
      infoBoxOutput("rf_fraud_box", width = 3),
      infoBoxOutput("rf_genuine_box", width = 3)
    ),
    fluidRow(
      box(
        title = "Fraud Transactions", status = "danger", solidHeader = TRUE,
        collapsible = TRUE, DTOutput("rf_datatable",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "LIME Model Interpretation", status = "primary", solidHeader = TRUE,
        collapsible = TRUE, plotOutput("rf_limeplot",
          height = 500
        ) %>% withSpinner()
      ),

      box(
        title = "Risk Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("rf_plot",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "Timeline Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("rf_barplot",
          height = 500
        ) %>% withSpinner()
      )
    )
  ))
)
