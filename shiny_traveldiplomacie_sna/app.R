#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

sliderInput()

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Select a region you want to inspect", 
                  choices = c("Northern America","Southern Asia"))
    ),
    mainPanel(
     textOutput(outputId = "selected"),
     tableOutput(outputId = "x"),
     plotOutput(outputId = "plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  un_regions <- read_csv("data/un_regions.csv")
  load("data/shiny_data.Rdata")
  
  coi <- reactive({
    un_regions %>% 
      filter(sub_region == input$region) %>% 
      filter(alpha_3 %in% V(rd_igraph)$name) %>% 
      pull(alpha_3)
      })
  
  rd_region <- reactive({
    induced.subgraph(graph=rd_igraph,vids=unlist(neighborhood(graph=rd_igraph,order=1,nodes=coi())))
  })
  
  output$selected <- renderText({input$region})
  output$x <- renderText({coi()})
  output$plot <- renderPlot({plot.igraph(rd_region())})
  
}

# Run the application 
shinyApp(ui = ui, server = server)

