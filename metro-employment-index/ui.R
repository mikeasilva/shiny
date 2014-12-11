shinyUI(
  fluidPage(
    title = 'Metro Employment Levels',
    responsive = TRUE,
  
    fluidRow(
      column(width = 12, 
             h2('Metro Employment Levels'), 
             p('The following presents seasonally adjusted employment levels indexed to two possible points in time (baselines).  You can highlight one metro area\'s data.  For more information about how the index was created visit ', a('http://rpubs.com/mikesilva/metro-employment-index'), '.'))
    ),
    fluidRow(
      column(width = 6, selectInput('dataset', 'Baseline', c('Jan 2000 = 100','Nov 2007 = 100'))),
      column(width = 6, selectInput('highlight', 'Highlight', c('None',msa.names)))
    ),
    fluidRow(
      column(width = 12, align='center', plotOutput('plot'))
    )
  )
)