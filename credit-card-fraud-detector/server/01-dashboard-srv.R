## Render info box
output$transaction_box <- renderInfoBox({
  real_data <- sampled_data()
  infoBox(
    "Transaction",
    paste0(count({
      real_data
    })),
    icon = icon("list"),
    color = "blue",
    fill = TRUE
  )
})


output$amount_box <- renderInfoBox({
  real_data <- sampled_data() %>% na.omit()
  infoBox(
    "Amount",
    paste0(sum(real_data$Amount)),
    icon = icon("money"),
    color = "green",
    fill = TRUE
  )
})
output$alert_box <- renderInfoBox({
  real_data <-
    predict_fraudxg() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 1)
  infoBox(
    "Alerts",
    paste0(real_data$count),
    icon = icon("bell", lib = "glyphicon"),
    color = "red",
    fill = TRUE
  )
})


## Render the plots
output$plot1 <- renderHighchart({
  hchart(
    sampled_data() %>% group_by(Time_hr) %>% tally(),
    "column",
    hcaes(x = Time_hr, y = n),
    name = "No of Transaction"
  ) %>%
    hc_yAxis(title = list(text = "No of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "No of Transaction Every Hour")
})


output$plot2 <- renderHighchart({
  hchart(
    sampled_data() %>% group_by(Time_hr) %>% summarise(Total = sum(Amount)),
    "column",
    hcaes(x = Time_hr, y = Total),
    color = "#85bb65",
    name = "Amount $"
  ) %>%
    hc_yAxis(title = list(text = "Amount of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "Amount of  Transaction Every Hour")
})
