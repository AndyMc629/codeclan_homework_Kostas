library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)

ui <- fluidPage(
  titlePanel(tags$h1("Five Country Medal Comparison")),
  titlePanel(tags$h4("The section below shows the total number of medals that awarded from each country that took place in the Olympic games in year xxxx. There were two main events, the Summer and Winter Olympic games.You can choose eithernseasonal event from the tab 'Season'. The medals are grouped in three categories, Gold, Silver and Bronze. You can see the number of awarded medals by their category by selecting the tab 'Which Medals'. Finally, you are able to see a bar chart in tab 'Plot'")),
  
  tabsetPanel(
    tabPanel("Season",
             radioButtons("season",
                          tags$h3("Summer or Winter Olympics?"),
                          choices = c("Summer", "Winter")
             )
    ),
    tabPanel("Which Medals?",
             radioButtons("medal",
                          tags$h3("Compare Which Medals?"),
                          choices = c("Gold", "Silver", "Bronze")
             )
    ),
    tabPanel("Plot",
             plotOutput("medal_plot")
    )
  )
)

server <- function(input, output) {
  
  
  output$medal_plot <- renderPlot({
    
    olympics_overall_medals %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$medal) %>%
      filter(season == input$season) %>%
      ggplot() +
      aes(x = team, y = count, fill = medal) +
      geom_col() +
      scale_fill_manual(values = c(
        "Gold" = "#DAA520",
        "Silver" = "#C0C0C0",
        "Bronze" = "#CD7F32"))
    
    
    
  })
}

shinyApp(ui = ui, server = server)

