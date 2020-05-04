#library(tidyverse)
#library(shiny)
#library(CodeClanData)

game_sales %>% 
  filter(publisher == "Nintendo") %>% 
  ggplot()+
  aes(x= platform, y = sales, fill = genre) +
  geom_col() +
  labs(title = "Number of copies")