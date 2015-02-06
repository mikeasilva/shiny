shinyUI(pageWithSidebar(
  headerPanel('Metro Commodity Flow Maps'),
  sidebarPanel(
    selectInput('msa.filter', 'Metro Area', metros)
  ),
  mainPanel(
   plotOutput('destination.plot'),
   plotOutput('origin.plot')
  )
))