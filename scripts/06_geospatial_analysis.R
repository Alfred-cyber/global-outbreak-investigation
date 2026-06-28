# Geospatial Analysis


library(tidyverse)
library(sf)

outbreak_data <- read_csv(
  "data/processed/outbreak_clean.csv",
  show_col_types = FALSE
)

district_locations <- tibble(
  district = c(
    "North",
    "South",
    "East",
    "West"
  ),
  longitude = c(
    5.20,
    5.20,
    5.40,
    5.00
  ),
  latitude = c(
    9.40,
    9.00,
    9.20,
    9.20
  )
)

district_locations



district_cases <- outbreak_data %>%
  count(district)

district_cases




hotspots <- district_locations %>%
  left_join(
    district_cases,
    by = "district"
  )

hotspots





hotspots_sf <- st_as_sf(
  hotspots,
  coords = c(
    "longitude",
    "latitude"
  ),
  crs = 4326
)

hotspots_sf


print(hotspots_sf)


saveRDS(
  hotspots_sf,
  "data/processed/hotspots_sf.rds"
)