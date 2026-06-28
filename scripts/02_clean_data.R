# Data Cleaning


library(tidyverse)
library(janitor)
library(lubridate)

outbreak_data <- read_csv(
  "data/raw/outbreak_cases.csv"
)

outbreak_data <- outbreak_data %>%
  clean_names()
names(outbreak_data)

colSums(is.na(outbreak_data))

sum(duplicated(outbreak_data))
glimpse(outbreak_data)

unique(outbreak_data$sex)

unique(outbreak_data$district)

unique(outbreak_data$status)

# Save cleaned Data Set

write_csv(
  outbreak_data,
  "data/processed/outbreak_clean.csv"
)
