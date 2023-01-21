library(tidyverse)
library(conflicted)
library(sf)
library(sp)  # deal with spatial data


conflict_prefer("select", "dplyr")
shp <- st_read("data/lsoa_dz_merged/lsoa_dz_merged.shp") %>%
  st_transform(crs = 4326)

shp$norm <- runif(nrow(shp))


mydata <- shp %>%
  dplyr::select(-TotPop2011, -ResPop2011, -HHCnt2011, -StdAreaHa, -Shape_Area, -BNG_E, -BNG_N)  # select all columns except the coords
