shinyUI(
  fluidPage(
    title = "Metro Employment Levels",
    fluidRow(
      column(width = 12, h2("Metro Employment Levels"))
    ),
    fluidRow(
      column(width = 6, selectInput('dataset', 'Baseline', c('Jan 2000 = 100','Nov 2007 = 100'))),
      column(width = 6, selectInput('highlight', 'Highlight', c('None',msa.names)))
    ),
    fluidRow(
      column(width = 12, plotOutput('plot'))
    )
  )
)