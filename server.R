library(shiny)
library(ggplot2)
library(DT)

source("makeplots.R") #PK
fdrdata <- read.csv("fdrdata.csv")

shinyServer(function(input, output) {

  dataInput_FDR <- reactive({
   input_data <- pvalueData[row.names(pvalueData) %in% input$journals & 
                              year >= input$years[1] & 
                              year <= input$years[2],]
   
   
  })
  
  dataInput_outtable <- reactive({
    subset(fulldata, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
  })
  
  
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
    
    #DT::datatable(dataInput_outtable)
  })
  
  # Histogram of pre and post p-values
  output$hist <- renderPlot({
    data1 <- dataInput_FDR()
    data2 <- dataInput_outtable()
    
    hist(data1$ppv, by=journal)
    hist(data2$pvals, by=journal)
  })
  
})
