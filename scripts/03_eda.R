# Exploratory Data Analysis


library(tidyverse)

outbreak_data <- read_csv(
  "data/processed/outbreak_clean.csv",
  show_col_types = FALSE
)

total_cases <- nrow(outbreak_data)

total_cases

cases_by_status <- outbreak_data %>%
  count(status)

cases_by_status

cases_by_district <- outbreak_data %>%
  count(district, sort = TRUE)

cases_by_district


cases_by_sex <- outbreak_data %>%
  count(sex)

cases_by_sex

summary(outbreak_data$age)


outbreak_data <- outbreak_data %>%
  mutate(
    age_group = case_when(
      age < 18 ~ "Child",
      age < 40 ~ "Adult",
      TRUE ~ "Older Adult"
    )
  )

count(outbreak_data, age_group)


write_csv(
  cases_by_status,
  "outputs/tables/cases_by_status.csv"
)

write_csv(
  cases_by_district,
  "outputs/tables/cases_by_district.csv"
)

write_csv(
  cases_by_sex,
  "outputs/tables/cases_by_sex.csv"
)



