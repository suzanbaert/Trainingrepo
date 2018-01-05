library(shiny)
ui <- fluidPage(
  titlePanel("My first dodgy shiny app"),
  sidebarPanel(
    sliderInput(inputId = "num",label = "Choose a number",value = 25, min = 1, max = 100)),
  mainPanel(
    plotOutput("hist")
  )
    )

server <- function(input, output) {
  output$hist <- renderPlot( hist(rnorm(input$num)))
  
  
}

shinyApp(ui = ui, server = server)