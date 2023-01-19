library(tidyverse)
library(conflicted)
library(sf)


conflict_prefer("select", "dplyr")
shp <- st_read("data/infuse_lsoa_lyr_2011_clipped/infuse_lsoa_lyr_2011_clipped.shp") %>%
  st_transform("+init=epsg:4326")

shp$norm <- runif(nrow(shp))

mydata <- shp