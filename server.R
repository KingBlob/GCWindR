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
    selectInput("clubname", "Club",
                choices = CLUBNAMES[[clubType()]],
                selected = club_default("t", clubType(),
                                        c(input$driver_d_t,
                                          input$wood_d_t,
                                          input$longiron_d_t,
                                          input$shortiron_d_t,
                                          input$wedge_d_t,
                                          input$roughiron_d_t,
                                          input$sandwedge_d_t)))
  })
  
  output$clevel <- renderUI({
    selectInput("clublevel", "Level",
                choices = c(1:10),
                selected = club_default("l", clubType(),
                                        c(input$driver_d_l,
                                          input$wood_d_l,
                                          input$longiron_d_l,
                                          input$shortiron_d_l,
                                          input$wedge_d_l,
                                          input$roughiron_d_l,
                                          input$sandwedge_d_l)))
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