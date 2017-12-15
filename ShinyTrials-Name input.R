library(shiny)
ui <- fluidPage(
  titlePanel(title = "Personal data"),
  
  sidebarPanel(
    textInput(inputId = "Name", label = "Name:"),
    textInput(inputId = "Age", label = "Age:"),
    selectInput(inputId = "City", label = "City:", choices = c("Brussels", "Leuven")),
    radioButtons(inputId = "Gender", label = "Gender", choices = c("Male", "Female")),
    actionButton(inputId="Submit", label="Submit")
    ),
  
  mainPanel(
    textOutput("OutputName"),
    textOutput("OutputAge"),
    textOutput("OutputCity"),
    textOutput("OutputGender")
  )
 )


server <- function(input, output) {
  
  input
  
  output$OutputName <- renderText(paste0("The name on record is: ",input$Name))
  output$OutputAge <- renderText(paste0("The age on record is: ",input$Age))
  output$OutputCity <- renderText(input$City)
  output$OutputGender <- renderText(input$Gender)
}


# server <- function(input, output) {
# #   output$myname <- renderText({input$name})
#   output$myage <- renderText({input$age})
#   output$mygender <- renderText({input$gender})
#   output$mycity <- renderText({input$city})
# }

shinyApp(ui = ui, server = server)
