library(shiny)

server <- function(input, output) {
  output$OutputName <- renderText(paste0("The name on record is actually: ",input$Name))
  output$OutputAge <- renderText(paste0("The age on record is: ",input$Age))
  output$OutputCity <- renderText(input$City)
  output$OutputGender <- renderText(input$Gender)
}