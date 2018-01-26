library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)



#DATA

#data import
#source data: kaggle (https://www.kaggle.com/kemical/kickstarter-projects/data)
kickstarter <- read_csv("data/kickstarter_data_2018.csv")
country_info <- read_csv("data/country_codes.csv")





#COLUMNS SECTION ####

#selecting columns: order of selection determines the order in the output
kickstarter %>%
  select(name, category, main_category, state)

#selecting a chunk of columns
kickstarter %>%
  select(name:main_category, state, backers)

#deselecting columns
kickstarter %>%
  select(-ID, -(currency:pledged))

#selecting based on names
kickstarter %>%
  select(contains("category"), starts_with("g"), ends_with("pledged"))

#selecting based on regex
kickstarter %>%
  select(matches("^c.+y$"))

#select if
kickstarter %>%
  select_if(is.character)



#renaming columns
kickstarter %>%
  rename(usd_pledged = `usd pledged`)

#changing the order of columns
kickstarter %>%
  select(main_category, category, name, state)

#just changing one: moving it to the back
kickstarter %>%
  select(name, main_category, category) %>%
  select(-name, name) 

#and renaming in a select
kickstarter %>%
  select(main_category, category, project = name, category, state)


#saving a piped datarame
kickstarter <- kickstarter %>%
  rename(usd_pledged = `usd pledged`)



#changing columns: mutate gives a new column
kickstarter %>%
  select(main_category, project = name, state, launched) %>%
  mutate(date =as.Date(launched))

#you can immediately use the newly created column
kickstarter %>%
  select(main_category, project = name, state, launched) %>%
  mutate(date =as.Date(launched)) %>%
  mutate(year = lubridate::year(date))

#changing the order so i don't keep any other variables
kickstarter %>%
  mutate(date =as.Date(launched)) %>%
  mutate(year = lubridate::year(date)) %>%
  select(main_category, project = name, state, year) 

#transmute: keeps only the newly created column
kickstarter %>%
  select(main_category, project = name, state, launched) %>%
  mutate(date =as.Date(launched)) %>%
  transmute(year = lubridate::year(date))


#putting two columns together
kickstarter %>%
  unite(goal_currency, currency, goal, sep=" ") %>%
  select(name, goal_currency)


#adding external country data
country_info

#splitting column data
country_info <- country_info %>%
  separate(ISO_CODES, into = c("code_alpha2", "code_alpha3"), sep = " / ")

#joining column data
kickstarter %>%
  select(project = name, state, country) %>%
  left_join(country_info, by = c("country" = "code_alpha2"))

#####

# ROWS ####





