# Package Installation

#install.packages("tidyverse")
#install.packages("janitor", type = "binary")
#install.packages("lubridate", type = "binary")

#Import packages
library(tidyverse)
library(janitor)
library(lubridate)

# Read outbreak data

outbreak_data <- read_csv(
  "data/raw/outbreak_cases.csv"
)

outbreak_data

dim(outbreak_data)

nrow(outbreak_data)

ncol(outbreak_data)