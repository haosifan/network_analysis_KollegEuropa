#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(igraph)
library(threejs)
library(dplyr)

load(file = "../data/data_preprocessed.Rdata")

max_degree <- as.numeric(as.vector(which.max(degree(rd_igraph))))
max_betweenness <- as.numeric(as.vector(which.max(betweenness(rd_igraph))))


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Reisediplomatie der EU28"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins_degree",
                     "# of degree",
                     min = 0,
                     max = max_degree,
                     value = 0),
         radioButtons("projection", "Projektion:",
                      c("Two-Mode" = "twomode",
                        "One-Mode EU" = "oneeu28",
                        "One-Mode Drittstaaten" = "oneother")
         )
      ),
     
     # Show a plot of the generated distribution
     mainPanel(
       plotOutput("distPlot")
     )
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     
      V(rd_igraph)$degree <- degree(rd_igraph, mode = "all")
      V(rd_igraph)$betweenness <- betweenness(rd_igraph)
      
      rd_igraph_plot <- rd_igraph %>% 
        induced_subgraph(vids = V(rd_igraph)$degree > input$bins_degree)
        
     
      plot.igraph(rd_igraph_plot, 
                  vertex.color=V(rd_igraph_plot)$type)
     
      # generate bins based on input$bins from ui.R
      #x    <- faithful[, 2] 
      #bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      #hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

