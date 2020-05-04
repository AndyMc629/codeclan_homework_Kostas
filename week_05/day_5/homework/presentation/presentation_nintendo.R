# In this script, we present the results related with Nintendo.

#library(tidyverse)
#library(shiny)
#library(CodeClanData)

all_name <- unique(nintendo_sales$name)
all_developer <- unique(nintendo_sales$developer)
all_genre <- unique(nintendo_sales$genre)
all_publisher <- unique(nintendo_sales$publisher)
all_sales <- unique(nintendo_sales$sales)
all_year <- unique(nintendo_sales$year_of_release)
all_platform <- unique(nintendo_sales$platform)



ui <- fluidPage(
  
  titlePanel(tags$b("Nintendo Games")),
  
  tabsetPanel(
    # ----
    # Tab 1 - 
    # ----
     tabPanel("Nintendo Dataset",
        
  fluidRow(
    column(4,
           selectInput("nintendo_developer",
                        "Which Developer?",
                        choices = all_developer,
                       selected = "Nintendo")
    ),
    column(4,
           selectInput("nintendo_platform",
                       "Which Platform?",
                       choices = all_platform)
    ),
    column(4,
           selectInput("nintendo_genre",
                       "Genre",
                       choices = all_genre)
    )
  ),
  
  actionButton("nintendo_update", "Find Games!"),
  tableOutput("table_output")
  
     ),
  # ----
  # Tab 2 - 
  # ----
  tabPanel("Nintendo Developers",
           plotOutput("nintendo_developers"),
           mainPanel(tags$i("The above graph, Fig.1, shows the number of games, in percent, that were developed by each 
                            developer company. Nintendo has it's own developer team and has created 68 out of 86 games. This number corresponds 
                            to 79.1% of the total games published by Nintendo Publisher. Konami and TT Games developer companies have created only 
                            one game each that is published by Nintendo Publisher.")),
           plotOutput("nintendo_sales"),
           mainPanel(tags$i("The above graph, Fig.2, shows the number of copies sold, in percent, that were developed by each 
                            developer company. As expected, Nintendo developer has the highest number of copies sold - this is due to 
                            the reason that Nintendo developer company has created the most games for `Nintendo (see figure above).
                            EA developer has created a half number of games for Nintendo, in comparison to Capcom, but the percentage
                            in copies for each company was the same, 1.6%.  
                            Namco publisher created 8 games for Nintendo (which corresponds to 9.3% of total games) but it's sales percentage
                            is only 1.1%"))  
           ),
  
  tabPanel("Nintendo Sales",
           plotOutput("nintendo_platforms"),
           plotOutput("nintendo_genre"))

  )
)

server <- function(input, output) {

# Tab 1    
  intendo_data <- eventReactive(input$nintendo_update,{
    
    nintendo_sales %>%
      filter(genre == input$nintendo_genre) %>% 
      filter(platform ==  input$nintendo_platform) %>% 
      filter(developer == input$nintendo_developer) %>% 
      slice(1:10)
  })
# table  
  output$table_output <- renderTable({
    intendo_data()
  })
  
 
# Tab 2   
# plot 1  
  output$nintendo_developers <- renderPlot({
  game_sales_Nintendo <-
    mutate(game_sales_Nintendo, developer = fct_reorder(developer, percentage))
  
  game_sales_Nintendo %>% 
    ggplot()+
    aes(x= developer, y = percentage, fill = developer) +
    geom_col()+
    coord_flip()+
    labs(title = "Number of games, in percentage, by each developer")
  })
  
  
  game_sales_Nintendo <- game_sales %>% 
    select(name,publisher, developer, platform) %>% 
    filter(publisher == "Nintendo") %>% 
    group_by(developer) %>% 
    summarise(count = n()) %>% 
    mutate(percentage = round((count*100)/sum(count), 2))
  
  
  
#plot 2  
  output$nintendo_sales <- renderPlot({
    game_sales_copies<-
      mutate(game_sales_copies, developer = fct_reorder(developer, percentage))
    
    game_sales_copies %>% 
      ggplot()+
      aes(x= developer, y = percentage, fill = developer) +
      geom_col()+
      coord_flip()+
      labs(title = "Number of copies sold, in percentage, by each developer")
  })
  
# Tab 3   
# plot 1 
  output$nintendo_platforms <- renderPlot({
    
    game_sales %>% 
      filter(publisher == "Nintendo") %>% 
      ggplot()+
      aes(x= platform, y = sales, fill = genre) +
      geom_col() +
      labs(title = "Sales with respect to platform")
  })
  
# plot 2 
  output$nintendo_genre <- renderPlot({  
  game_sales %>% 
    filter(publisher == "Nintendo") %>% 
    ggplot()+
    aes(x= genre, y = sales, fill = platform) +
    geom_col() +
    labs(title = "Sales with respect to genre")
  })
  
  
}

shinyApp(ui = ui, server = server)