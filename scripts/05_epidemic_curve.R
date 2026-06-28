#install.packages("plotly",  type = "binary")

# Global Outbreak Investigation Unit
#  Epidemic Curve


library(tidyverse)
library(plotly)

outbreak_data <- read_csv(
  "data/processed/outbreak_clean.csv",
  show_col_types = FALSE
)


daily_cases <- outbreak_data %>%
  count(report_date)

daily_cases


epi_curve <- ggplot(
  daily_cases,
  aes(
    x = report_date,
    y = n
  )
) +
  geom_col() +
  labs(
    title = "Epidemic Curve",
    subtitle = "Daily Reported Cases",
    x = "Report Date",
    y = "Number of Cases"
  ) +
  theme_minimal()

epi_curve


ggsave(
  filename = "outputs/figures/epidemic_curve.png",
  plot = epi_curve,
  width = 8,
  height = 5
)


interactive_epi_curve <- ggplotly(epi_curve)

interactive_epi_curve

