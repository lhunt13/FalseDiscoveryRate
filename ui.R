
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
      
      p("Select the journal(s) and year(s) for which you want to see the False Discovery Rates. The False
        Discovery rate is calculated from the significant p-values in the selected papers using the 
        method"),
      
      checkboxGroupInput("journals",
        label = "Select Journal(s)",
        choices = list("JAMA", 
                       "New England Journal of Medicine",
                       "BMJ",
                       "American Journal of Epidemiology",
                       "Lancet"),
        selected = "JAMA"
      ),
      
      sliderInput("years", label = h3("Year of publication"),
                  min = 2000, max = 2010, 
                  value = c(2004,2005))
      ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Dataset", DT::dataTableOutput("table")),
                  tabPanel("Hisogram". plotOuput("hist"))
      )
    )
  )
))
