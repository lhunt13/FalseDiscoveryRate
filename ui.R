
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

# test3
# test2
#
# test3 Prosenjit

# test4 lamar



library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("False Discovery Rate Calculator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("discipline","Choose a Discipline",
                  choices = list("Choice 1" = 1,
                                 "Choice 2" = 2,
                                 "Choice 3" = 3),
                  selected = 1
                  )
        
      ),
    mainPanel("main panel")
    )
))
