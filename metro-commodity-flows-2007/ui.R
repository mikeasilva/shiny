library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel('2007 Metro Commodity Flow Visualizer'),
  
  # Sidebar with controls to select the mode and metro
  sidebarLayout(
    sidebarPanel(
      selectInput('mode', 'Commodity', c('Outflows', 'Inflows')),
      selectInput('msa.filter', 'for', metros) # metros loaded in global.R
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = 'tabs', 
                  tabPanel('Map', plotOutput('flow.plot')),  
                  tabPanel('Table', dataTableOutput('flow.table')),
                  tabPanel('Documentation', 
                           h3('Introduction'),
                  
                           p('This application shows the commodity inflows and outflows from metro area in the USA.  The data comes from the commodity flow survey which is undertaken through a partnership between the Census Bureau and the Bureau of Transportation Statistics.  It is conducted every 5 years (years ending in "2" and "7") as part of the Economic Census.  2007 is the latest data available at the time this application was created.  This application allows you to visualize the flow of all commodities for metros in the lower 48 States.'),
                           
                           h3('How To Use It'),
                           p('Select what you would like to see (i.e. inflows or outflows) from the dropdown menu.  Next select the metro you want to visualize.  The map will update with lines showing the flows.  The darker the line the higher the value of the commodities.  The data tables also update showing the underlying data.')
                          
                           )
      )
    )
  )
))