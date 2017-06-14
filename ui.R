
# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  headerPanel("Application Test"),
  sidebarPanel(
    p("Demo Page."),
    textInput(inputId = "comment", # this is the name of the
              # variable- this will be
              # passed to server.R
              label = "Enter hashtag", # display label for the
              # variable
              value = "" # initial value
    ),
    
    sliderInput(inputId = "minimumTime",
                label = "Select number of words",
                min = 100,
                max = 1000,
                value = 0,
                step = 50),
    actionButton("doBtn", "Click Here...")
  ),
  mainPanel(
    textOutput("textDisplay"),
    #htmlOutput("text2"),
    plotOutput("plot")
  )
  
  
))

