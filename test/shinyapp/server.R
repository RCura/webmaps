library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
    
    # Expression that generates a plot of the distribution. The expression
    # is wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should be automatically 
    #     re-executed when inputs change
    #  2) Its output type is a plot 
    #
    output$distPlot <- renderPlot({
        
        # generate an rnorm distribution and plot it
        dist <- rnorm(input$obs)
        hist(dist)
    })
    
    output$distPlot2 <- renderPlot({
        
        # generate an rnorm distribution and plot it
        dist <- rnorm(input$obs)
        hist(dist)
    })
    
    output$webmap <- renderUI({
        state <- data.frame(state.x77)
        state$Name <- rownames(state)
        state$color <- strtrim(rainbow(n=nrow(state)), 7)
        coordinates(state) <- cbind(state.center$x, state.center$y)
        
        abc <- webmap(layer(layerData = state,
                            name = "States",
                            lstyle(
                                pointRadius = '${Murder}',
                                fillColor = "${color}",
                                strokeColor = "black",
                                fillOpacity = 0.4)),
                      title="Test",
                      toShiny=TRUE)
        return(HTML(abc))
    })
    
    
})
