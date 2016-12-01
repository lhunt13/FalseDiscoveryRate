library(shiny)
library(ggplot2)

source("makeplots.R") #PK
fdrdata <- read.csv("fdrdata.csv")

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    fdrdata <- subset(fdrdata, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    makeplot(fdrdata) #---fdrdata <- calfdr(df)---#
  })
  
})
