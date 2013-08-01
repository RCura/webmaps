library(shiny)

shinyServer(function(input, output, session) {
    
    if (!require(webmaps)) {
        require(devtools)
        install_github(repo = "webmaps", username = "RCura") ; require(webmaps)
    }
    
    
    output$webmap <- renderUI({
        
        state <- data.frame(state.x77)
        state$Name <- rownames(state)
        state$color <- strtrim(rainbow(n=nrow(state)), 7)
        coordinates(state) <- cbind(state.center$x, state.center$y)
        HTML(webmap(layer(layerData = state,
                     name = paste('Map', input$obs, sep=""),
                     lstyle(
                         pointRadius = '${Murder}',
                         fillColor = "${color}",
                         strokeColor = "black",
                         fillOpacity = 0.4)),
               toShiny=TRUE))
    })
    
    observe({
        input$obs
        myMsg <- "$('#map').empty(); init()"
        session$sendCustomMessage(type='jsCode', list(value = myMsg))
    })
})
