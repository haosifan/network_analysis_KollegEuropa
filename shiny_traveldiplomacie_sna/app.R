#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(tidyverse)
library(igraph)
library(visNetwork)
library(countrycode)
library(lubridate)


un_regions <- read_csv("data/un_regions.csv")
load("data/shiny_data.Rdata")
kolleg_regions <- read_csv2("data/regions_iso3.csv") %>% 
  mutate(cntry_name = countrycode(cntry_iso, origin = "iso3c", destination = "country.name"),
         cntry_name = case_when(cntry_iso == "KSV" ~ "Kosovo",
                                TRUE ~ cntry_name))

projection_eu <- igraph::bipartite_projection(rd_igraph, which = "true")

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Select a region you want to inspect:", 
                  choices = unique(kolleg_regions$region_en)),
      dateRangeInput("daterange", label = "Choose a date range:", 
                     start = min(ymd(E(rd_igraph)$date), na.rm = TRUE), end = max(ymd(E(rd_igraph)$date), na.rm = TRUE)),
      radioButtons("type", "Select which projection is used for SNA-statistics:", 
                   choiceNames = c("EU Projection","Host Country Projection"), choiceValues = c("true","false"))
    ),
    mainPanel(
     textOutput(outputId = "selected"),
     tableOutput(outputId = "x"),
     visNetworkOutput(outputId = "networkplot")
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
  
  vn <- reactive({
    vnd <- toVisNetworkData(rd_region())
    nodes <- vnd$nodes %>% 
      mutate(color.background = case_when(type == FALSE ~ "lawngreen",
                                          type == TRUE ~ "lightblue")) %>% 
      data.frame()
    
    edges <- data.frame(vnd$edges)
    visNetwork(nodes, edges)
    })
  
  
  projection_stats <- reactive({
    
    region_strength <- strength(projection_eu) %>% 
      data.frame() %>% 
      rownames_to_column(var = "iso3") %>% 
      rename(strength = ".")
    
    region_eigen <- eigen_centrality(projection_eu, weights = E(projection_eu)$weight)$vector %>% 
      data.frame() %>% 
      rownames_to_column(var = "iso3") %>% 
      rename(eigenvector_centr = ".")
    
    left_join(region_strength, region_eigen, by = "iso3") %>% DT::datatable()
  })
  
  
  output$selected <- renderText({input$region})
  output$x <- renderText({coi()})
  output$networkplot <- visNetwork::renderVisNetwork({vn()})
}

# Run the application 
shinyApp(ui = ui, server = server)

