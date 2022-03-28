library(shiny)
source("functions.R")


#
#
#


ui <- fluidPage(
  column(
    3,
    selectInput("clubtype", "Clubtype",
                c("drivers", "woods", "longirons", "shortirons", "wedges", "roughirons", "sandwedges"),
                selected = "drivers"),
    uiOutput("uiout"),
    selectInput("clublevel", "Level", c(1,2,3,4,5,6,7,8,9,10)),
    uiOutput("shotdistance"),
    sliderInput("wind", "Wind", 0, 16, 0, round = -1, step = 0.1),
    verbatimTextOutput("minmax"),
    sliderInput("ele", "Elevation", -60, 60, 0, step = 5),
    verbatimTextOutput("windpr"),
    verbatimTextOutput("rings")
  ),
  column(
    6,
    plotOutput("test")
  ),
  column(
    2,
    h5("Welcome to the wind chart app!"),
    h6("A work in progess, this app does not have all the clubs on the spreadsheet."),
    
    
    # Driver defaults
    fluidRow(
      column(6, selectInput("driver_d_t", "Driver Tour", c(1:7), selected = 1)),
      column(6, selectInput("driver_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Wood defaults
    fluidRow(
      column(6, selectInput("wood_d_t", "Wood Tour", c(1:7), selected = 1)),
      column(6, selectInput("wood_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Long iron defaults
    fluidRow(
      column(6, selectInput("longiron_d_t", "LIron Tour", c(1:7), selected = 1)),
      column(6, selectInput("longiron_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Short iron defaults
    fluidRow(
      column(6, selectInput("shortiron_d_t", "SIron Tour", c(1:7), selected = 1)),
      column(6, selectInput("shortiron_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Wedge defaults
    fluidRow(
      column(6, selectInput("wedge_d_t", "Wedge Tour", c(1:7), selected = 1)),
      column(6, selectInput("wedge_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Rough iron defaults
    fluidRow(
      column(6, selectInput("roughiron_d_t", "RIron Tour", c(1:7), selected = 1)),
      column(6, selectInput("roughiron_d_l", "Level", c(1:10), selected = 1))
    ),
    
    # Sand wedge defaults
    fluidRow(
      column(6, selectInput("sandwedge_d_t", "SWedge Tour", c(1:7), selected = 1)),
      column(6, selectInput("sandwedge_d_l", "Level", c(1:10), selected = 1))
    )
  )
  
)