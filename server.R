library(shiny)
source("functions.R")


#
#
#


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
    tempselect <- CLUBNAMES[[clubType()]][as.integer(defaultdriver())]
    print(tempselect)
    selectInput("clubname", "Club",
                choices = CLUBNAMES[[clubType()]],
                selected = tempselect)
  })
  
  defaultdriver <- reactive({
    input$driverdtour
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