#test script

library(leaflet)
library(rgdal)

LSOA <- readOGR("data/lsoa_dz_merged/lsoa_dz_merged.shp")
plot(LSOA)

m <- leaflet () %>%
  addProviderTiles(providers$OpenStreetMap) %>%
  addPolygons(data = LSOA, 
              stroke = TRUE,
              weight=0.5,
              color="#37B1ED",
              opacity=1,
              fillColor = "#37B1ED",
              fillOpacity = 0.5)
m