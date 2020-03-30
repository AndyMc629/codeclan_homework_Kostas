library(tidyverse)
library(shiny)
library(CodeClanData)

# Sales
game_sales_copies <- game_sales %>% 
  select(publisher, developer, year_of_release, sales) %>% 
  filter(publisher == "Nintendo") %>%
  group_by(developer) %>% 
  summarise(copies_sales_in_millions= sum(sales)) %>% 
  mutate(percentage = round((copies_sales_in_millions*100)/sum(copies_sales_in_millions), 4))

# Plot the results
game_sales_copies<-
  mutate(game_sales_copies, developer = fct_reorder(developer, percentage))

game_sales_copies %>% 
  ggplot()+
  aes(x= developer, y = percentage, fill = developer) +
  geom_col()+
  coord_flip()+
  labs(title = "Number of copies sold in percentage")