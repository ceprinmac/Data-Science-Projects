library(shiny)  
library(ggplot2)  
library(dplyr)  

housing = read.csv('C:/Users/user/Desktop/RTut/housing.csv')
head(housing)
summary(housing)

ui <- fluidPage(  
  titlePanel("Housing Data Dashboard"),  
  
  sidebarLayout(  
    sidebarPanel(  
      h4("Summary of Homes"),  
      tableOutput("homes_summary")  
    ),  
    
    mainPanel(  
      plotOutput("population_households_plot"),  
      plotOutput("rooms_bedrooms_plot")  
    )  
  )  
)  

server <- function(input, output) {  
  
  # Count homes by location  
  output$homes_summary <- renderTable({  
    housing %>%  
      group_by(ocean_proximity) %>%  
      summarise(count = n()) %>%  
      arrange(desc(count))  
  })  
  
  # Population vs Households  
  output$population_households_plot <- renderPlot({  
    ggplot(housing, aes(x = population, y = households)) +  
      geom_point(alpha = 0.5) +  
      labs(title = "Population vs Households",  
           x = "Population",  
           y = "Households") +  
      theme_minimal()  
  })  
  
  # Total Rooms vs Total Bedrooms  
  output$rooms_bedrooms_plot <- renderPlot({  
    ggplot(housing, aes(x = total_rooms, y = total_bedrooms)) +  
      geom_point(alpha = 0.5) +  
      labs(title = "Total Rooms vs Total Bedrooms",  
           x = "Total Rooms",  
           y = "Total Bedrooms") +  
      theme_minimal()  
  })  
}  

shinyApp(ui = ui, server = server)
