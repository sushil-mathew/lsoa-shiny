
library(tidyverse)
library(conflicted)
library(sf)
library(sp)  # deal with spatial data

load("data/mydata.Rdata")

conflict_prefer("select", "dplyr")
