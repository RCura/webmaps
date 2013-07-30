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
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("distPlot"),
        htmlOutput('webmap'),
        includeHTML('test.txt'),
        div(id='map')
    )
))
