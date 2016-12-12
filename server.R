library(shiny)
library(ggplot2)
library(DT)
library(plyr)
library(dplyr)

source("makeplots.R") #PK
source("Hist.R") #PK

FDRbyYEAR <- read.csv("fdrdata.csv")

source("calfdr_v2.R") #KS

shinyServer(function(input, output) {

  #gives dataframe with FDRs and posterior pvals computed by journal 
  dataInput_FDR <- reactive({
    
    load("pvalueData.rda")
   input_data <- pvalueData[row.names(pvalueData) %in% input$journals &
                              pvalueData[,4] %in% input$years[1]:input$years[2],]

   
   # Create a list of subsetted matrices
   my_data <- my_pvalueData(input_data)
   
   
   # Calculate both the swfdr and the ppv 
   fdrdata <- calFDR(my_data)

   
   # Result
   fdrdata
   
  })
  
  
  #plots FDR by year and by journal
  output$plot <- renderPlot({
    FDRbyYEAR <- subset(FDRbyYEAR, journal %in% input$journals & year >= input$years[1] & year <= input$years[2])
    makeplot(FDRbyYEAR) #---FDRbyYEAR <- calfdr(df)---#
  })
  
  #makes DataTable for user to search
  output$table <- DT::renderDataTable({
    data_outtable <- dataInput_FDR()
    DT::datatable(data_outtable)
  })
  
  #gives histogram of pre and post p-values
  output$hist <- renderPlot({
  #  data1 <- dataInput_FDR()
    data_hist <- dataInput_FDR()
    makehist(data_hist)  
  #  hist(data1$ppv, by=journal)
  #  hist(data2$pvals, by=journal)
  })
  
})

