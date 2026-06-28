# Visualisations

library(tidyverse)

outbreak_data <- read_csv(
  "data/processed/outbreak_clean.csv",
  show_col_types = FALSE
)

cases_by_status <- outbreak_data %>%
  count(status)

cases_by_district <- outbreak_data %>%
  count(district, sort = TRUE)

cases_by_sex <- outbreak_data %>%
  count(sex)


district_plot <- ggplot(
  cases_by_district,
  aes(
    x = reorder(district, n),
    y = n
  )
) +
  geom_col() +
  labs(
    title = "Reported Cases by District",
    x = "District",
    y = "Number of Cases"
  ) +
  theme_minimal()

district_plot



ggsave(
  filename = "outputs/figures/cases_by_district.png",
  plot = district_plot,
  width = 8,
  height = 5
)




status_plot <- ggplot(
  cases_by_status,
  aes(
    x = status,
    y = n
  )
) +
  geom_col() +
  labs(
    title = "Cases by Status",
    x = "Case Status",
    y = "Number of Cases"
  ) +
  theme_minimal()

status_plot


ggsave(
  filename = "outputs/figures/cases_by_status.png",
  plot = status_plot,
  width = 8,
  height = 5
)



sex_plot <- ggplot(
  cases_by_sex,
  aes(
    x = sex,
    y = n
  )
) +
  geom_col() +
  labs(
    title = "Cases by Sex",
    x = "Sex",
    y = "Number of Cases"
  ) +
  theme_minimal()

sex_plot

ggsave(
  filename = "outputs/figures/cases_by_sex.png",
  plot = sex_plot,
  width = 8,
  height = 5
)




