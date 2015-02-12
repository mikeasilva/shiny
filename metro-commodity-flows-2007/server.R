library(dplyr)

shinyServer(function(input, output, session){
  
  origin.data <- reactive({
    data %>%
      filter(Origin == input$msa.filter)
  })
  
  destination.data <- reactive({
    data %>%
      filter(Destination == input$msa.filter)
  })
  
  getMapData <- function(){
    if(input$mode == 'Outflows'){
      map.data <- origin.data()
    } else {
      map.data <- destination.data()
    }
    map.data
  }
  
  getTableData <- function(){
    table.data <-  getMapData() %>%
      select(Destination, Origin, Value.in.millions.of.dollars) %>%
      arrange(desc(Value.in.millions.of.dollars))
    
    names(table.data) <- c('Going to', 'Comming From', 'Value (millions of dollars)')
    
    if(input$mode == 'Outflows'){
      table.data <- table.data[,names(table.data) %in% c('Going to', 'Value (millions of dollars)')]
    }else{
      table.data <- table.data[,2:3]
    }
    
    table.data
  }
  
  output$flow.table <- renderDataTable(
    getTableData(),
    options = list(
      paging=FALSE,
      searching = FALSE,
      scrollY= 400
    )
  )
  
  createPlot <- function(map.data){  
    library(maps)
    library(geosphere)
    
    map('state', interior=FALSE, col='#CCCCCC')
    map('state', boundary=FALSE, col='#F0F0F0', add=TRUE)
    
    ## Colors from http://colorbrewer2.org/
    if(input$mode == 'Outflows'){
      pal <- colorRampPalette(c('#e5f5e0', '#00441b')) # Green
    } else {
      pal <- colorRampPalette(c('#fee0d2', '#67000d')) # Red
    }
    
    title(paste('Commodity', input$mode, 'for', input$msa.filter))
    
    colors <- pal(100)
    
    max.value <- max(map.data$Value.in.millions.of.dollars)
    
    ## Draw great circle for each flow line
    for (j in 1:nrow(map.data)) 
    {
      m <- map.data[j,]
      inter <- gcIntermediate(c(m$Origin.Lon, m$Origin.Lat), c(m$Destination.Lon, m$Destination.Lat), n=100, addStartEnd=TRUE)
      colindex <- round((m$Value.in.millions.of.dollars/max.value) * length(colors))
      lines(inter, col=colors[colindex], lwd=1)
    }
    
    ## Plot all metros as points
    metro <- data %>% 
      select(Origin.Lat, Origin.Lon) %>% 
      unique()    
    points(metro$Origin.Lon, metro$Origin.Lat, pch=19, col='#CCCCCC')
  }
  
  output$flow.plot <- renderPlot({  
    map.data <- getMapData()
    createPlot(map.data)
  })
  
})