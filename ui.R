#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(sf)
library(tidyverse)
library(DT)
library(plotly)
library(shinyjs)
library(htmlwidgets)
library(mapdeck)


# Choices for drop-downs: Have it in this format, perhaps add countries
vars <- c("Random data" = "norm")

navbarPage(
  
  # title of app 
  title = "LSOA", 
  id = "home",
  
  
  tabPanel("Map", 
           value = "map",
           div(class = "outer",
               
               tags$head(
                 # Include custom CSS
                 includeCSS("styles.css"),
                 # includeScript("gomap.js")
                 useShinyjs()
                 
                 #waiterOnBusy(),
                 
               ),
               
               # leafletOutput(
               #     "map" 
               #     ,width = "100%" 
               #     ,height = "100%"
               # ),
               mapdeckOutput(
                 outputId = 'map',
                 width = "100%",
                 height = "100%"
               ),
               
               # draggable panel to select inequality measure and level
               absolutePanel(
                 id = "controls", 
                 class = "panel panel-default", 
                 fixed = TRUE,
                 draggable = TRUE, 
                 top = 300, 
                 left = 50, 
                 right = "auto", 
                 bottom = "auto",
                 width = 330, 
                 height = "auto",
                 
                 h2("LOOT explorer"),
                 
                 
                 # options: income / wealth / housing
                 # options: 
                 #fluidRow(
                 #  column(6, actionButton("options", "More options")),
                 #  column(6, downloadButton("download", "Download data"))
                 # ),
                 
                 # TODO draw your own area? cf. nebular.gl (R port?)
                 
                 # TODO
                 # distribution of house values in area
                 #withSpinnter()plotlyOutput("house_values", height = 200),
                 # plotOutput("scatterCollegeIncome", height = 250)
               ),
               
               # tags$div(id = "cite",
               #  'Data compiled for ', tags$em('Measuring local, salient inequality in the UK'), ' by Joel H Suss.'
               # ),
               
           )
  ), # end Map tab
  
  
  
  tabPanel(
    "About", value = "about",
    #useMarkdown()
    
  ) # end About panel
  
)
