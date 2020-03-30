library(tidyverse)
library(shiny)
library(CodeClanData)

game_sales %>% 
  filter(publisher == "Nintendo") %>% 
  ggplot()+
  aes(x= genre, y = sales, fill = platform) +
  geom_col() +
  labs(title = "sales with respect to genre")