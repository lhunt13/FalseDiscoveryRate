# LH: I think we should split up "getPvals" and "calcFDR" because
# then we can make our app more flexible if we add other methods
# for user input, like uploading a paper

library(shiny)

source("makeplots.R") #PK

shinyServer(function(input, output) {
  
  #LH: this function should get the user inputs and
  # produce a vector of p-values
  # "getPvals"
  
  
  #LH: this function should take a vector of p-values and 
  # spit out a FDR
  # "calcFDR"
  source("calfdr.R")
  fdrdata <- calFDR(df)
  
  
  #LH: output a plot here
  output$plot <- renderPlot({
    makeplot(fdrdata) #---fdrdata <- calfdr(df)---#
  })
  
})
