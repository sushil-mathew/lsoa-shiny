#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)


# Choices for drop-downs: Have it in this format, perhaps add countries
vars <- c("Random data" = "norm")



navbarPage("Interactive Maps", id="nav",
           
           tabPanel("LSOA(2011)",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css")
                        ),
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map", width="100%", height="100%"),
                        
                        
                        # Panel to select variable
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      selectInput("variable", "Variable", vars, selected = "norm"),
                                      actionButton(inputId = "reset", label = "Return", class = "btn-primary")
                        ),
                        
                        tags$div(id="cite",
                                 'Data compiled for ', tags$em('Index'), ' by Sushil Mathew(2022)'
                        )
                    )
           ),
)