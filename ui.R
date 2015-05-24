library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Miles Per Gallon calculation on Motor Trend Car Road Tests data"),
  
  # Choosing variables for plot and analysis
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("Cylinders" = "cyl", 
                     "Transmission" = "am", 
                     "Gears" = "gear")),
    
    # for dispalying trend line 
    checkboxInput("trend", "Trend line and some info", FALSE)
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    plotOutput("mpgPlot"),
    h4(textOutput("regression"))
    
    
  )
))