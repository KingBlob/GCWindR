library(shiny)
source("functions.R")


#
#
#


ui <- fluidPage(
  column(
    4,
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
    
    fluidRow(
      column(6, selectInput("driverdtour", "Tour", c(1:7), selected = 1)),
      column(6, selectInput("driverdlevel", "Level", c(1:10), selected = 1))
    ),
    fluidRow(
      column(6, selectInput("wooddtour", "Tour", c(1:7), selected = 1)),
      column(6, selectInput("wooddlevel", "Level", c(1:10), selected = 1))
    )
  )
  
)