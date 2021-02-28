# Created by: Sergi Arias Ruiz
# Location: Reus.Catalonia.Spain
# Linkedin profile: https://www.linkedin.com/in/sariasruiz
# GitHub Repository: https://github.com/sariasruiz/Shiny-Application-and-Reproducible-Pitch
# License: https://creativecommons.org/licenses/by/4.0/
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com/
#

# Loading packages
library(shiny)
library(leaflet)
library(leaflet.extras)
library(dplyr)
library(plotly)

# Loading data
accidents2019 <- read.csv("https://opendata-ajuntament.barcelona.cat/data/dataset/834b8920-0685-4e16-8e20-faf13645f4f3/resource/4bf617c6-7fe0-4e6a-b010-1c6fef544a31/download/2019_accidents_tipus_gu_bcn_.csv", 
                          sep = ",",
                          header = TRUE,
                          encoding = "UTF-8")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$Filter_hour <- renderLeaflet({

        # Filtering by type: Vehicle-Pedestrian Collisions
        accidents2019 <- accidents2019 %>%
        filter(accidents2019$Mes_any >= min(input$month) &
                   accidents2019$Mes_any <= max(input$month) &
                   accidents2019$Hora_dia >= min(input$hour) &
                   accidents2019$Hora_dia <= max(input$hour) & 
                   accidents2019$Nom_districte == input$district &
                   accidents2019$Descripcio_tipus_accident == "Atropellament")
        
        # Mapping
        accidents2019 %>% 
            leaflet() %>%
            addTiles() %>%
            # Mapping Markers
            addMarkers(lng=~as.numeric(Longitud),
                       lat=~as.numeric(Latitud),
                       popup = accidents2019$Descripcio_tipus_accident,
                       clusterOptions = markerClusterOptions())%>%
            addProviderTiles(providers$CartoDB.Positron) %>%
            # Mapping Heatmap
            addHeatmap(lng=~as.numeric(Longitud),
                       lat=~as.numeric(Latitud),
                       radius = 8)  %>%
            # Mapping Mini Map
            addMiniMap(
                tiles = providers$Esri.WorldStreetMap,
                toggleDisplay = TRUE)
        })
    })