library(shiny)
library(ggplot2)
library(DT)

source("makeplots.R") #PK
FDRbyYEAR <- read.csv("fdrdata.csv")

shinyServer(function(input, output) {

  #gives dataframe with FDRs and posterior pvals computed by journal 
  dataInput_FDR <- reactive({
   input_data <- pvalueData[row.names(pvalueData) %in% input$journals & 
                              year >= input$years[1] & 
                              year <= input$years[2],]
   
   
  })
  
  #gives table to place in DataTable tab
  dataInput_outtable <- reactive({
    subset(fulldata, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
  })
  
  #plots FDR by year and by journal
  output$plot <- renderPlot({
    FDRbyYEAR <- subset(FDRbyYEAR, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    makeplot(FDRbyYEAR) #---FDRbyYEAR <- calfdr(df)---#
  })
  
  
  #makes DataTable for user to search
  output$table <- DT::renderDataTable({
    test <- data.frame(journal = rep(c("JAMA", 
                                       "New England Journal of Medicine",
                                       "BMJ",
                                       "American Journal of Epidemiology",
                                       "Lancet"),10), year = rep(2000:2009, 5))
    outputtable <- subset(test, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    DT::datatable(outputtable)
    
    data <- dataInput_FDR()
    #DT::datatable(dataInput_outtable)
  })
  
  #gives histogram of pre and post p-values
  output$hist <- renderPlot({
    data1 <- dataInput_FDR()
    data2 <- dataInput_outtable()
    
    hist(data1$ppv, by=journal)
    hist(data2$pvals, by=journal)
  })
  
})

