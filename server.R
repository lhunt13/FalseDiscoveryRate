library(shiny)
library(ggplot2)
library(DT)

source("makeplots.R") #PK
fdrdata <- read.csv("fdrdata.csv")

shinyServer(function(input, output) {
  
  output$plot <- renderPlot({
    fdrdata <- subset(fdrdata, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    makeplot(fdrdata) #---fdrdata <- calfdr(df)---#
  })
  
  
  # Output table -- for now, there is a "test" table as a placeholder until we get the table we will output
  output$table <- DT::renderDataTable({
    test <- data.frame(journal = rep(c("JAMA", 
                                       "New England Journal of Medicine",
                                       "BMJ",
                                       "American Journal of Epidemiology",
                                       "Lancet"),10), year = rep(2000:2009, 5))
    outputtable <- subset(test, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    DT::datatable(outputtable)
  })
  
})
