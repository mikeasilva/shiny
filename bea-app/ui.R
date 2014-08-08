shinyUI(pageWithSidebar(
  headerPanel('BEA Data Explorer'),
  sidebarPanel(
    h2('Plot Variables'),
    selectInput('xcol', 'X Variable', names(bea.data), selected=names(bea.data)[[4]]),
    selectInput('ycol', 'Y Variable', names(bea.data), selected=names(bea.data)[[3]]),
    
    h2('Filters'),
    selectInput('year.filter', 'Year(s) Showing', c('All',bea.data[!duplicated(bea.data$year),c('year')])),
    selectInput('msa.filter', 'MSA(s) Showing', c('All',bea.data[!duplicated(bea.data$msa.fips),c('msa.fips')])),
    
    
    
    h2('Clusters'),    
    sliderInput('clusters', 'How many clusters do you want to see?', 
                min=1, max=9, value=5),
    checkboxInput('show.centers', 'Show center(s)', FALSE)
  ),
  mainPanel(
    plotOutput('plot1')
  )
))