library(shinydashboard)
library(shinythemes)
library(shinydashboardPlus)
library(shinycssloaders)
library(ggplot2)
library(readr)
library(dplyr)
library(shiny)
library(gridExtra)
library(h2o)
library(highcharter)
library(data.table)
library(DT)
library(lime)
library(dashboardthemes)


## Intialize the h2o
h2o.init()

## Load saved model
model <- h2o.loadModel("/home/diwash/projeckt/credit_card_feaud/model/GBM_model_R_1558482610633_2")
## Random Forest
modelrf <- h2o.loadModel("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/model/improve/DRF_model_R_1561701961587_4087")
## Xgboost
modelxg <- h2o.loadModel("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/model/improve/XGBoost_model_R_1561701961587_2048")
## GBM model
modelgb <- h2o.loadModel("/home/diwash/projeckt/credit_card_feaud/credit-card-fraud-detector/model/improve/GBM_model_R_1561701961587_2817")


## For LIME
train <- fread("/home/diwash/projeckt/credit_card_feaud/train.csv")
explainer <- lime(train, model, n_bins = 5)
explainer_xg <- lime(train, modelxg, n_bins = 5)
explainer_gb <- lime(train, modelgb, n_bins = 5)
explainer_rf <- lime(train, modelrf, n_bins = 5)


#### Highcharter
# standard theme
highcharts_demo()

# creting custom theme with new colors
newtheme <- hc_theme_merge(
  getOption("highcharter.theme"),
  hc_theme(colors = c("red", "orange", "green"))
)

# setting as default
options(highcharter.theme = newtheme)
