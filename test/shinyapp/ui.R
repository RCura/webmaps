library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Hello Shiny!"),
    
    
    # Sidebar with a slider input for number of observations
    sidebarPanel(
        tags$head(webmapTags()),
        sliderInput("obs", 
                    "Number of observations:", 
                    min = 1,
                    max = 1000, 
                    value = 500)
    ),
    mainPanel(
            htmlOutput('webmap'),
            div(id='map', style='width: 500px ;height: 400px'),
            div(id='status')
    )
))
