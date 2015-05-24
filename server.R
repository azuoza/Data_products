library(shiny)
library(datasets)
library(ggplot2)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression for lm
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the regression formula 
  output$regression <- renderText({
    if(input$trend == TRUE){
      model <- lm(as.formula(formulaText()), data = mpgData)
      paste("Formula of the trend line is: mpg = ", 
            round(summary(model)$coefficients[1,1], 1), 
            ifelse(test = summary(model)$coefficients[2,1] > 0, yes = " + ", no = " - "),
            abs(round(summary(model)$coefficients[2,1], 1)),
            " * ", 
            input$variable)
    }
  })
  
  # Generate a plot of the requested variable against mpg and  
  # include trend line if requested
  output$mpgPlot <- renderPlot({
    if(input$variable == "cyl"){
      pl <- ggplot(data = mpgData, aes(x = cyl, y = mpg)) + geom_point()
    } else if(input$variable == "am"){
      pl <- ggplot(data = mpgData, aes(x = am, y = mpg)) + geom_point()
    } else {
      pl <- ggplot(data = mpgData, aes(x = gear, y = mpg)) + geom_point()
    }   
    
    
    if(input$trend == TRUE){
      pl <- pl +  geom_smooth(method = "lm", se=FALSE, aes(group = 1))
    }
    print(pl)
  })
})