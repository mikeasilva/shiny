shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    df2 <- F
    if(input$highlight != 'None'){
      df2 <- filter(df, msa.name == input$highlight)
    }
    df2
  })
  
  output$plot <- renderPlot({
    if(input$dataset == 'Jan 2000 = 100'){
      the.plot <- plot1
    }else{
      the.plot <- plot2
    }
    # Highlighted metro   
    if(input$highlight != 'None'){
      if(input$dataset == 'Jan 2000 = 100'){
        print(the.plot + geom_line(mapping = aes(x=date, y=y2k.emp.indx, group = series_id), data=selectedData(), color=alpha("#cc0000", .5)))
      }else{
        print(the.plot + geom_line(mapping = aes(x=date, y=emp.indx, group = series_id), data=selectedData(), color=alpha("#cc0000", .5)))
      }
    }
    else {
      print(the.plot)
    }
  }, height = 800, width = 800)
  
})