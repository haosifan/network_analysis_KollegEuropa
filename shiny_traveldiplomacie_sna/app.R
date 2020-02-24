#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Select a region you want to inspect", 
                  choices = c("Eastern and South-Eastern Asia","Latin America and the Caribbean"))
    ),
    mainPanel(
     textOutput(outputId = "selected"),
     textOutput(outputId = "x")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  load("../data/data_addvars_network.Rdata")

  output$selected <- renderPrint({input$region})
  
  x <- reactive({input$region == "Eastern and South-Eastern Asia"})
  
  output$x <- renderPrint({x})
}

# Run the application 
shinyApp(ui = ui, server = server)

