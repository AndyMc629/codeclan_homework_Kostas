library(tidyverse)
library(shiny)
library(CodeClanData)

# Find the developers for Nintendo
game_sales_Nintendo <- game_sales %>% 
  select(name,publisher, developer, platform) %>% 
  filter(publisher == "Nintendo") %>% 
  group_by(developer) %>% 
  summarise(count = n()) %>% 
  mutate(percentage = round((count*100)/sum(count), 2))

# Plot the results
game_sales_Nintendo <-
  mutate(game_sales_Nintendo, developer = fct_reorder(developer, percentage))

game_sales_Nintendo %>% 
  ggplot()+
  aes(x= developer, y = percentage, fill = developer) +
  geom_col()+
  coord_flip()+
  labs(title = "Developer companies that are used to make games for Nintendo")