library(shiny)  
library(shinydashboard)  
library(ggplot2)  

# Define UI  
ui <- dashboardPage(  
  dashboardHeader(title = "Iris Dashboard"),  
  dashboardSidebar(  
    sidebarMenu(  
      menuItem("Visualizations", tabName = "visualizations", icon = icon("bar-chart"))  
    )  
  ),  
  dashboardBody(  
    tabItems(  
      tabItem(tabName = "visualizations",  
              fluidRow(  
                box(title = "Scatter Plot", status = "primary", solidHeader = TRUE,   
                    plotOutput("scatterPlot")),  
                box(title = "Box Plot", status = "warning", solidHeader = TRUE,   
                    plotOutput("boxPlot")),  
                box(title = "Bar Chart", status = "success", solidHeader = TRUE,   
                    plotOutput("barChart"))  
              ),  
              fluidRow(  
                box(title = "Interactive Species Selector", status = "info", solidHeader = TRUE,  
                    selectInput("species", "Select Species", choices = unique(iris$Species)),  
                    plotOutput("interactivePlot")  
                )  
              )  
      )  
    )  
  )  
)  

# Define Server  
server <- function(input, output) {  
  
  # Scatter Plot  
  output$scatterPlot <- renderPlot({  
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +  
      geom_point() +  
      theme_minimal() +  
      labs(title = "Sepal Length vs Sepal Width")  
  })  
  
  # Box Plot  
  output$boxPlot <- renderPlot({  
    ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +  
      geom_boxplot() +  
      theme_minimal() +  
      labs(title = "Box Plot of Petal Length by Species")  
  })  
  
  # Bar Chart  
  output$barChart <- renderPlot({  
    ggplot(iris, aes(x = Species)) +  
      geom_bar(fill = "steelblue") +  
      theme_minimal() +  
      labs(title = "Count of Each Species", x = "Species", y = "Count")  
  })  
  
  # Interactive Plot  
  output$interactivePlot <- renderPlot({  
    selected_species <- input$species  
    ggplot(iris[iris$Species == selected_species, ], aes(x = Petal.Length, y = Petal.Width)) +  
      geom_point(color = "red") +  
      theme_minimal() +  
      labs(title = paste("Petal Length vs Petal Width for", selected_species))  
  })  
}  

# Run the application   
shinyApp(ui = ui, server = server) 
