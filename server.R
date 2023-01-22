#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#change lat and long
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



# Define server logic required to map inequality and allow for data download
function(input, output, session) {
  
  
  # return lon lat, bounding box and zoom of current view
  observeEvent({input$map_view_change},{
    print(input$map_view_change)
    
  })
  

  
  ## Interactive Map ###########################################
  
  # Create the static map (mapdeck version)
  output$map <- renderMapdeck({
    mapdeck(
      style = mapdeck_style('dark'),
      location = c(-2.93, 54.3), 
      zoom = 5 
    )
  })
  
  observe({
    
    mapdeck_update(map_id = 'map') %>%
      add_polygon(
        data = mydata
        , fill_colour = input$measure
        , layer_id = "inequality"
        , fill_opacity = 0.7
        #, colour_range = colourvalues::colour_values(1:6, palette = "plasma")
        , palette = "plasma"
        , auto_highlight = T
        , highlight_colour = "#FFFFFFFF"
        , tooltip = "info"
        , id = "id"
        , legend = T
        # , legend_options = list(
        #     list( title = input$measure %>% str_to_title)
        #     #, css = "max-height: 100px;" ## css applied 
        # )
        , digits = 3
        , update_view = FALSE
      ) 
  })
  
  
  
  
  # popups with info on area
  # Show a popup at the given location
  show_popup <- function(id, lat, lng) {
    
    # selected_area <- df()[df()$id == id,] %>% 
    #     st_drop_geometry()
    
    selected_area <- mydata$norm %>% 
      st_drop_geometry()
    
    print(selected_area)
    
    content <- as.character(
      tagList(
        tags$h4(
          # display inequality value
          input$measure,
          sprintf(": %s%%",selected_area[[input$measure]])
        ),
        tags$strong(
          HTML(
            sprintf(
              "%s, %s %s",
              selected_area$id, 
              selected_area$id, 
              selected_area$id
            )))
      ))
    print(content)
    leafletProxy("map") %>% addPopups(lng, lat, content#, layerId = ~ id
    )
  }
}

