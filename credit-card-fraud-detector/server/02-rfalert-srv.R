## Render the infobox
output$rf_transaction_box <- renderInfoBox({
  infoBox(
    "Transaction",
    paste0(count(sampled_data())),
    icon = icon("list"),
    color = "blue",
    fill = TRUE
  )
})


output$rf_amount_box <- renderInfoBox({
  real_data <- sampled_data() %>% na.omit()
  infoBox(
    "Amount",
    paste0(sum(real_data$Amount)),
    icon = icon("money"),
    color = "green",
    fill = TRUE
  )
})
output$rf_fraud_box <- renderInfoBox({
  real_data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 1)
  infoBox(
    "RF Alerts",
    paste0(real_data$count),
    icon = icon("bell", lib = "glyphicon"),
    color = "red",
    fill = TRUE
  )
})


output$rf_genuine_box <- renderInfoBox({
  real_data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    tally(name = "count") %>%
    filter(predict == 0)
  infoBox(
    "Genuine",
    paste0(real_data$count),
    icon = icon("ok", lib = "glyphicon"),
    color = "green",
    fill = TRUE
  )
})

## Render the fraud transaction table
output$rf_datatable <- renderDataTable({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  data <- mutate(data, risk = case_when(
    data$p1 <= .50 ~ "Low",
    data$p1 <= .90 ~ "Medium",
    data$p1 > .90 ~ "High"
  ))
  fwrite(data, "./fraud/random_forest.csv", row.names = FALSE)
  DT::datatable(data,
    selection = "single",
    options = list(searching = FALSE, scrollX = TRUE)
  ) %>% formatStyle(
    "risk",
    target = "row",
    backgroundColor = styleEqual(c("Low", "Medium", "High"), c("#91ea73", "#fba132", "#f35f5f"))
  )
})

## render the lime plots
output$rf_limeplot <- renderPlot({
  #  input$run_model                                 # button input
  validate(
    need(input$rf_datatable_rows_selected, "Click on a Row from the Table")
  )

  index <- input$rf_datatable_rows_selected
  #  index <- isolate(input$datatable_rows_selected)             # use isolate to run model only on button press
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  #  plot(data$V1,data$V5)
  #  plot(iris$Sepal.Length,iris$Petal.Width)
  plot_features(explain(
    data[index, 1:32],
    explainer_rf,
    n_features = 10, labels = 1, n_permutations = 5000,
    dist_fun = "gower",
    kernel_width = .25, feature_select = "lasso_path"
  )) + ggtitle("Model Explanation")
})

output$rf_plot <- renderHighchart({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  data <- mutate(data, Risk = case_when(
    data$p1 <= .50 ~ "Low",
    data$p1 <= .90 ~ "Medium",
    data$p1 > .90 ~ "High"
  ))

  hchart(data$Risk, colorByPoint = TRUE, name = "Risk") %>%  hc_legend(enabled = F)
})

output$rf_barplot <- renderHighchart({
  data <-
    predict_fraudrf() %>%
    group_by(predict) %>%
    filter(predict == 1)
  hchart(
    data %>% group_by(Time_hr) %>% tally(),
    "column",
    color = "#B71C1C",
    hcaes(x = Time_hr, y = n),
    name = "No of Fraud Transactions"
  ) %>%
    hc_yAxis(title = list(text = "No of Transaction")) %>%
    hc_xAxis(title = list(text = "Time in Hours")) %>%
    hc_title(text = "Fraud Transaction Every Hour")
})
