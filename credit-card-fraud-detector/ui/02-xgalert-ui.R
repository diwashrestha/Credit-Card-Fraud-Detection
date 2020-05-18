tabItem(
  tabName =
    "xgalert",

  fluidRow(column(
    width = 12,
    fluidRow(
      infoBoxOutput("xg_transaction_box", width = 3),
      infoBoxOutput("xg_amount_box", width = 3),
      infoBoxOutput("xg_fraud_box", width = 3),
      infoBoxOutput("xg_genuine_box", width = 3)
    ),
    fluidRow(
      box(
        title = "Fraud Transactions", status = "danger", solidHeader = TRUE,
        collapsible = TRUE, DTOutput("xg_datatable",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "LIME Model Interpretation", status = "primary", solidHeader = TRUE,
        collapsible = TRUE, plotOutput("xg_limeplot",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "Risk Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("xg_plot",
          height = 500
        ) %>% withSpinner()
      ),
      box(
        title = "Timeline Transaction", status = "info", solidHeader = TRUE,
        collapsible = TRUE, highchartOutput("xg_barplot",
          height = 500
        ) %>% withSpinner()
      )
    )
  ))
)
