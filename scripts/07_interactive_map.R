#Interactive Mapping


library(tidyverse)
library(sf)
library(leaflet)

hotspots_sf <- readRDS(
  "data/processed/hotspots_sf.rds"
)

hotspots_sf

hotspots_sf <- hotspots_sf %>%
  mutate(
    popup_text = paste0(
      "<b>District:</b> ", district,
      "<br>",
      "<b>Cases:</b> ", n
    )
  )



outbreak_map <- leaflet(
  hotspots_sf
) %>%
  addTiles() %>%
  addCircleMarkers(
    radius = ~n * 2,
    popup = ~popup_text,
    label = ~district
  )

outbreak_map



hotspot_summary <- hotspots_sf %>%
  st_drop_geometry() %>%
  arrange(desc(n))

hotspot_summary



write_csv(
  hotspot_summary,
  "outputs/tables/hotspot_summary.csv"
)
