---
  title: "R Notebook"
output: html_notebook
---


# We load the necessary packages for the analysis
library(readr)
library(here)
library(tidyverse)
library(janitor)
library(stringr)

# Storage the decathlon.rds file into an object, called "decathlon_data"
decathlon_data <- read_rds("raw_data/decathlon.rds")


# We assign a column name as "name" 
decathlon_tidy_data <- decathlon_data %>% 
  rownames_to_column("name")  

# We change the names of each sport
names(decathlon_tidy_data) <- c("name", "100m", "long_jump", "shot_put", "high_jump","400m","110m_hurdle", "discus","pole_vault","javeline","1500m","rank","points","competition") 


# We move columns into rows using the "pivot_longer" function 
decathlon_tidy_data <- decathlon_tidy_data %>% 
  pivot_longer(cols = c("100m", "long_jump", "shot_put",    "high_jump","400m","110m_hurdle","discus","pole_vault","javeline","1500m"), 
               names_to = "sports", 
               values_to = "scores")


# We set strings to lowcasecase across the column "name"
decathlon_tidy_data <- decathlon_tidy_data %>% 
  mutate(name = str_to_lower(name))


# We now write save the tidy file 
write_csv(decathlon_tidy_data, "clean_data/decathlon_tidy_data.csv")
