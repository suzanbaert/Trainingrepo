ui <- fluidPage(
  titlePanel(title = "Personal data"),
  
  sidebarPanel(
    textInput(inputId = "Name", label = "Name:"),
    textInput(inputId = "Age", label = "Age:"),
    selectInput(inputId = "City", label = "City:", choices = c("Brussels", "Leuven")),
    radioButtons(inputId = "Gender", label = "Gender", choices = c("Male", "Female"))
  ),
  
  mainPanel(
    textOutput("OutputName"),
    textOutput("OutputAge"),
    textOutput("OutputCity"),
    textOutput("OutputGender")
  )
)