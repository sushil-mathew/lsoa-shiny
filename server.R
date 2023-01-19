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
#library(leafem)
#library(raster)

function(input, output, session) {
  #colourpalette
  myPal  <- colorNumeric(palette = "Spectral", domain = mydata$values, na.color = "transparent")
  
  #Label on a pop-up window
  LABELS <- paste(mydata$name, mydata$norm)
  initial_lat = 55
  initial_lng = 14.5
  initial_zoom = 3
  
  output$map <- renderLeaflet({
    mydata %>%
      st_transform(crs = 4326) %>%
      leaflet() %>%
      addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
      setView(lng = initial_lng, lat = initial_lat, zoom = initial_zoom) %>%
      addPolygons(weight = 1,
                  layerId = mydata$name,
                  color = "white",
                  fillColor = ~myPal(norm),
                  fillOpacity = 0.7, 
                  label = LABELS) %>%
      addLegend("topright", pal = myPal, values = ~norm,
                title = "",
                opacity = 0.7)
  })
  
  observe({
    click <- input$map_shape_click
    if(is.null(click))
      return()
    
    leafletProxy("map") %>% 
      setView(lng = click$lng, lat = click$lat, zoom = 6)
  })
  
  
  observeEvent(input$reset, {
    leafletProxy("map") %>% setView(lat = initial_lat, lng = initial_lng, zoom = initial_zoom)
  })
}
