tabItem(
  tabName =
    "gbmalert",

  fluidRow(column(
    width = 12,
    fluidRow(
      infoBoxOutput("gbm_transaction_box", width = 3),
      infoBoxOutput("gbm_amount_box", width = 3),
      infoBoxOutput("gbm_fraud_box", width = 3),
      infoBoxOutput("gbm_genuine_box", width = 3)
    ),
    fluidRow(
      box(
        title = "Fraud Transactions", status = "danger", solidHeader = TRUE,
        collapsible = TRUE, DTOutput("gbm_datatable",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "LIME Model Interpretation", status = "primary", solidHeader = TRUE,
        collapsible = TRUE, plotOutput("gbm_limeplot",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "Risk Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("gbm_plot",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "Timeline Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("gbm_barplot",
          height = 500
        ) %>% withSpinner()
      )
    )
  ))
)
