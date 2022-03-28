library(shiny)
source("functions.R")



## Only run examples in interactive R sessions
if (interactive()) {
  
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
      h6("V1.0: Basic formatting, more to come!")
    )

  )
  
  server <- function(input, output) {
    # autoInvalidate <- reactiveTimer(2000)
    # observe({
    #   autoInvalidate()
    #   print(paste("The value of input$n is", isolate(input$n)))
    # })
    
    clubType <- reactive({
      input$clubtype
    })
    
    output$uiout <- renderUI({
      selectInput("clubname", "Club",
                  choices = CLUBNAMES[[clubType()]])
    })
    
    clubName <- reactive({
      input$clubname
    })
    
    clubLevel <- reactive({
      input$clublevel
    })
    
    cmax <- reactive({
      clubMaxDist(paste(clubName(), clubLevel(), sep = ""))
    })
    
    cmin <- reactive({
      clubMinDist(paste(clubName(), clubLevel(), sep = ""))
    })
    
    output$shotdistance <- renderUI({
      sliderInput("shotdist", "Shot Distance",
                  min = cmin(), max = cmax(), value = cmax(), step = 1)
    })
    
    sD <- reactive({
      input$shotdist
    })
    
    output$minmax <- renderText({
      paste("Min club dist:", cmin(), "   Max club dist:", cmax())
    })
    
    wprUI <- reactive ({
      windPerRing(paste(clubName(), clubLevel(), sep = ""), sD())
    })
    
    output$windpr <- renderText({
      paste("Wind per ring:", wprUI())
    })
    
    output$rings <- renderText({
      paste("Rings:",input$wind / wprUI() * (1+input$ele/100))
    })
    
    output$test <- renderPlot({
      drawRings()
      abline(h = input$wind/wprUI()*(1+input$ele/100), col = "green")
      abline(h = -input$wind/wprUI()*(1+input$ele/100), col = "green")
    },
    width = 500,
    height = 500
    )
  }
  
  shinyApp(ui, server)
}