shinyServer(function(input, output, session){
  
  origin.data <- reactive({
    data[data$Origin == input$msa.filter,]
  })
  
  destination.data <- reactive({
    data[data$Destination == input$msa.filter,]
  })
  
  createPlot <- function(msa.name, map.data, mode){  
    library(maps)
    library(geosphere)
    xlim <- c(-171.738281, -56.601563)
    ylim <- c(12.039321, 71.856229)
    base.map <- map('world', col='#f2f2f2', fill=TRUE, bg='white', lwd=0.05, xlim=xlim, ylim=ylim)
    
    
    if(mode == 'origin'){
      pal <- colorRampPalette(c('#f2f2f2', 'green'))
      title(paste0('Commodity Outflows for ', msa.name))
    } else {
      pal <- colorRampPalette(c('#f2f2f2', 'red'))
      title(paste0('Commodity Inflows for ', msa.name))
    }
    colors <- pal(100)
    max.value <- max(map.data$Value.in.millions.of.dollars)
        
    
    for (j in 1:nrow(map.data)) 
    {   
      inter <- gcIntermediate(c(map.data[j,]$Origin.Lon, map.data[j,]$Origin.Lat), c(map.data[j,]$Destination.Lon, map.data[j,]$Destination.Lat), n=100, addStartEnd=TRUE)
      colindex <- round((data[j,]$Value.in.millions.of.dollars/max.value) * length(colors))
      lines(inter, col=colors[colindex], lwd=0.8)
    }
  }
  
  output$origin.plot <- renderPlot({
    createPlot(input$msa.filter, origin.data(), 'origin')
    })
  
  output$destination.plot <- renderPlot({
    createPlot(input$msa.filter, destination.data(), 'destination')
  })
})