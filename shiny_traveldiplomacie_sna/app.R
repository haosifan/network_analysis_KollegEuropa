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
library(igraph)
library(visNetwork)
library(countrycode)

un_regions <- read_csv("data/un_regions.csv")
load("data/shiny_data.Rdata")
kolleg_regions <- read_csv2("data/regions_iso3.csv") %>% 
  mutate(cntry_name = countrycode(cntry_iso, origin = "iso3c", destination = "country.name"),
         cntry_name = case_when(cntry_iso == "KSV" ~ "Kosovo",
                                TRUE ~ cntry_name))

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Select a region you want to inspect:", 
                  choices = unique(kolleg_regions$region_en)),
      #sliderInput("year", "Choose a year", min = 2017, max = 2019, value = 2017),
      dateRangeInput("daterange", label = "Choose a date range:", 
                     start = min(ymd(E(rd_igraph)$date), na.rm = TRUE), end = max(ymd(E(rd_igraph)$date), na.rm = TRUE))
    ),
    mainPanel(
     textOutput(outputId = "selected"),
     tableOutput(outputId = "x"),
     visNetworkOutput(outputId = "networkplot"),
     visNetworkOutput(outputId = "proj_eu")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  coi <- reactive({
    kolleg_regions %>% 
      filter(region_en == input$region) %>% 
      filter(cntry_iso %in% V(rd_igraph)$name) %>% 
      pull(cntry_iso)
      })

  
  rd_region <- reactive({
    induced.subgraph(graph=rd_igraph,vids=unlist(neighborhood(graph=rd_igraph,order=1,nodes=coi()))) %>% 
      subgraph.edges(graph = ., eids = which(E(.)$date >= input$daterange[1] & E(.)$date <= input$daterange[2]))
  })
  
  #rd_eu <- igraph::bipartite_projection(rd_region(), which = "true")
  
  vn <- reactive({
    vnd <- toVisNetworkData(rd_region())
    nodes <- vnd$nodes %>% 
      mutate(color.background = case_when(type == FALSE ~ "lawngreen",
                                          type == TRUE ~ "lightblue")) %>% 
      data.frame()
    
    edges <- data.frame(vnd$edges)
    visNetwork(nodes, edges)
    })
  
 # vn_eu <- reactive({
 #   vnd_eu <- toVisNetworkData(rd_eu())
 #  visNetwork(data.frame(vnd_eu$nodes), data.frame(vnd_eu$edges))
 # })
  
  output$selected <- renderText({input$region})
  output$x <- renderText({coi()})
  output$networkplot <- visNetwork::renderVisNetwork({vn()})
  #output$proj_eu <- visNetwork::renderVisNetwork({vn_eu()})
}

# Run the application 
shinyApp(ui = ui, server = server)

