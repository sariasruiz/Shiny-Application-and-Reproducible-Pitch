# Created by: Sergi Arias Ruiz
# Location: Reus.Catalonia.Spain
# Linkedin profile: https://www.linkedin.com/in/sariasruiz
# GitHub Repository: https://github.com/sariasruiz/Shiny-Application-and-Reproducible-Pitch
# License: https://creativecommons.org/licenses/by/4.0/
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Vehicle-Pedestrian Collisions 2019 in Barcelona. Interactive Heatmap."),
    helpText(h4("This little project is a requirement for 
             the Developing Data Products subject under 
             the Data Science course of Johns Hopkins University.")),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("district", 
                        h3("District:"), 
                        choices = list("Ciutat Vella" = "Ciutat Vella",
                                       "Desconegut" = "Desconegut",
                                       "Eixample" = "Eixample",
                                       "Gràcia" = "Gràcia",
                                       "Horta-Guinardó" = "Horta-Guinardó",
                                       "Les Corts" = "Les Corts",
                                       "Nou Barris" = "Nou Barris",
                                       "Sant Andreu" = "Sant Andreu",
                                       "Sant Martí" = "Sant Martí",
                                       "Sants-Montjuïc" = "Sants-Montjuïc",
                                       "Sarrià-Sant Gervasi" = "Sarrià-Sant Gervasi"), 
                        selected = "Ciutat Vella"),
            sliderInput("hour",
                        h3("Hour:"),
                        min = 0,
                        max = 23,
                        value = c(0,23)),
            sliderInput("month",
                        h3("Month:"),
                        min = 1,
                        max = 12,
                        value = c(1,12)),
            helpText(h3("Help text:"),
                     "Use the sliders to filter visual 
                     information by district, hour, or month."
                     )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            leafletOutput("Filter_hour")
        )
    ),
    bootstrapPage(
        div(# You can use a string value as HTML by wrapping it with the HTML 
            # function. If you didn't do that, then the string would be treated as 
            # plain text and the HTML tags would be escaped. See ?HTML.
            HTML('Created by: <a rel="license" href="https://www.linkedin.com/in/sariasruiz/">Sergi Arias Ruiz</a>.'),
            HTML('GitHub Repository: <a rel="license" href="https://github.com/sariasruiz/Shiny-Application-and-Reproducible-Pitch">Shiny Application and Reproducible Pitch</a>.'),           
            HTML('<br /><a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Licencia de Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><br />Esta obra está bajo una <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">licencia de Creative Commons Reconocimiento 4.0 Internacional</a>.')
        ))
    ))
