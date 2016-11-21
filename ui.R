
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com


library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("False Discovery Rate Calculator"),

  # Sidebar with user inputs
  sidebarLayout(
    sidebarPanel(
      selectInput("discipline","Choose a Discipline",
                  choices = list("Choice 1" = 1,
                                 "Choice 2" = 2,
                                 "Choice 3" = 3),
                  selected = 1
                  )
        
      ),
    
    #LH: PK's plot feeds into here
    mainPanel(plotOutput("plot"))
    )
))
