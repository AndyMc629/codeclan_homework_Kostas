
#############################################################################
#                           Data Cleaning Scripts
#############################################################################


# We load the necessary packages for the analysis
library(readr)
library(here)
library(tidyverse)
library(janitor)
library(stringr)


# Storage the 'cake_ingredient_code.csv' file into an object, called "cake_ingredients_data"
cake_ingredients_data <- read_csv("raw_data/cake-ingredients-1961.csv")

# Storage the 'cake_ingredient_code.csv' file into an object, called "cake_ingredients_data_code"
cake_ingredients_code <- read_csv("raw_data/cake_ingredient_code.csv")



# We usew the 'pivot_longer' function to tidy up the given data. The new data is stored in an object called, "cake_ingredients_tidy_data".
cake_ingredients_tidy_data <- cake_ingredients_data %>% 
  pivot_longer(cols = c("AE":"ZH"), 
               names_to = "code", 
               values_to = "weight")

# We remove all the NAs from the new table
cake_ingredients_tidy_data<- cake_ingredients_tidy_data %>% 
  drop_na()



# We join the two tables together 
cake_ingredients_tidy_data <- left_join(cake_ingredients_tidy_data, 
                                        cake_ingredients_code, by = "code") 


# We remove the "code" column from the data
cake_ingredients_tidy_data <- cake_ingredients_tidy_data %>% 
  select(-code)

# We rename the "Cake" column to "cake" column
names(cake_ingredients_tidy_data) <- c("cake", "weight", "ingredient","measure") 
names(cake_ingredients_tidy_data)


# We set strings to lowcasecase across the column "ingredient" 
# Note:We keep the cake names as it is because they look consistent (from the column "cake")
cake_ingredients_tidy_data <- cake_ingredients_tidy_data %>% 
  mutate(ingredient = str_to_lower(ingredient))


# We now write the clean file and save it in the folder "clean_data" 
write_csv(cake_ingredients_tidy_data, "clean_data/cake_ingredients_tidy_data.csv")





