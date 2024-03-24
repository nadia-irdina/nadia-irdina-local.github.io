
library(shiny)

twd_episodes <- read.csv("the_walking_dead_episodes.csv")

# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Directors"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      selectInput(inputId = "writer",
                  label = "Choose a writer:",
                  choices = unique(twd_episodes$written_by)),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 177)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output, session) {
  
  
  # Show the first "n" observations with selected variable ----
  output$view <- renderTable({
    selected_writer <- input$writer
    filtered_data <- twd_episodes[twd_episodes$written_by == selected_writer,]
    head(filtered_data, n = input$obs)
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)