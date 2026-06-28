# --------------------------------------------------
# Global Outbreak Investigation Unit
# Outbreak Surveillance Dashboard
# --------------------------------------------------

# Load packages
library(shiny)
library(tidyverse)
library(DT)

# --------------------------------------------------
# Load Data
# --------------------------------------------------

outbreak_data <- read_csv(
  "../data/processed/outbreak_clean.csv",
  show_col_types = FALSE
)

# --------------------------------------------------
# Summary Metrics
# --------------------------------------------------

total_cases <- nrow(outbreak_data)

confirmed_cases <- outbreak_data %>%
  filter(status == "Confirmed") %>%
  nrow()

suspected_cases <- outbreak_data %>%
  filter(status == "Suspected") %>%
  nrow()

districts_affected <- outbreak_data %>%
  distinct(district) %>%
  nrow()

# --------------------------------------------------
# User Interface
# --------------------------------------------------

ui <- fluidPage(
  
  titlePanel("Global Outbreak Investigation Unit"),
  
  hr(),
  
  h3("Outbreak Surveillance Dashboard"),
  
  br(),
  
  fluidRow(
    
    column(
      3,
      wellPanel(
        h4("Total Cases"),
        h2(total_cases)
      )
    ),
    
    column(
      3,
      wellPanel(
        h4("Confirmed"),
        h2(confirmed_cases)
      )
    ),
    
    column(
      3,
      wellPanel(
        h4("Suspected"),
        h2(suspected_cases)
      )
    ),
    
    column(
      3,
      wellPanel(
        h4("Districts"),
        h2(districts_affected)
      )
    )
    
  ),
  
  br(),
  
  tabsetPanel(
    
    tabPanel(
      
      "Case Data",
      
      br(),
      
      DTOutput("cases_table")
      
    ),
    
    tabPanel(
      
      "Cases by District",
      
      br(),
      
      plotOutput("district_plot")
      
    ),
    
    tabPanel(
      
      "Cases by Status",
      
      br(),
      
      plotOutput("status_plot")
      
    ),
    
    tabPanel(
      
      "Cases by Sex",
      
      br(),
      
      plotOutput("sex_plot")
      
    )
    
  )
  
)

# --------------------------------------------------
# Server
# --------------------------------------------------

server <- function(input, output) {
  
  # Data Table
  output$cases_table <- renderDT({
    
    datatable(
      outbreak_data,
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
    
  })
  
  # Cases by District
  output$district_plot <- renderPlot({
    
    outbreak_data %>%
      count(district, sort = TRUE) %>%
      ggplot(
        aes(
          x = reorder(district, n),
          y = n
        )
      ) +
      geom_col() +
      labs(
        title = "Reported Cases by District",
        x = "District",
        y = "Cases"
      ) +
      theme_minimal()
    
  })
  
  # Cases by Status
  output$status_plot <- renderPlot({
    
    outbreak_data %>%
      count(status) %>%
      ggplot(
        aes(
          x = status,
          y = n
        )
      ) +
      geom_col() +
      labs(
        title = "Cases by Status",
        x = "Status",
        y = "Cases"
      ) +
      theme_minimal()
    
  })
  
  # Cases by Sex
  output$sex_plot <- renderPlot({
    
    outbreak_data %>%
      count(sex) %>%
      ggplot(
        aes(
          x = sex,
          y = n
        )
      ) +
      geom_col() +
      labs(
        title = "Cases by Sex",
        x = "Sex",
        y = "Cases"
      ) +
      theme_minimal()
    
  })
  
}

# --------------------------------------------------
# Launch App
# --------------------------------------------------

shinyApp(
  ui = ui,
  server = server
)


