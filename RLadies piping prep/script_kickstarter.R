library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)
library(forcats)
library(stringr)
library(lubridate)


#intro on piping
#use the pizza example
#how does piping work? 
#syntax of pipe operator



#DATA

#data import
#source data: kaggle (https://www.kaggle.com/kemical/kickstarter-projects/data)
kickstarter <- read_csv("data/kickstarter_data_2018.csv")
country_info <- read_csv("data/country_codes.csv")







#CRAWL EXAMPLES

#how many projects are successful versus other status's?
kickstarter %>%
  count(state) %>%
  arrange(desc(n))


kickstarter %>%
  group_by(state) %>%
  summarise(n = n(), percent = n/nrow(.)) %>%
  arrange(desc(n))


kickstarter %>%
  filter(main_category == "Technology") %>%
  group_by(state) %>%
  summarise(n = n(), percent = n/nrow(.)) %>%
  arrange(desc(n))


kickstarter %>%
  group_by(main_category) %>%
  summarise(perc_successful = mean(state == "successful")) %>%
  arrange(desc(perc_successful))





kickstarter %>%
  filter(main_category %in% c("Technology", "Design")) %>%
  group_by(state) %>%
  summarise(n = n(), percent = n/nrow(.)) %>%
  arrange(desc(n))

kickstarter %>%
  filter(main_category %in% c("Technology", "Design")) %>%
  group_by(state, main_category) %>%
  summarise(n = n(), percent = n/nrow(.)) %>%
  arrange(desc(n))


#which project received the most backers?
kickstarter %>%
  select(main_category, category, project = name, backers) %>%
  arrange(desc(backers))



#what different categories are there? 
kickstarter %>%
  group_by(main_category) %>%
  arrange %>%
  pull(main_category)


#which category has the highest succes
kickstarter %>%
  count(main_category, state) %>%
  spread(state, n) %>%
  select(main_category, successful, failed) %>%
  mutate(total = failed + successful,
         prct_successful = successful/total) %>%
  arrange(desc(prct_successful))


#which category has the highest succes
#
kickstarter %>%
  count(main_category, state) %>%
  spread(state, n) %>%
  select(main_category, successful, failed) %>%
  mutate(total = failed + successful,
         prct_successful = successful/total) %>%
  arrange(desc(total)) %>%
  ggplot()+
    geom_col(aes(x=fct_inorder(main_category), y=total, fill=prct_successful)) +
    scale_fill_viridis_c(option="viridis", direction = -1, guide = guide_legend("Percent successful")) +
    labs(title = "Number of kickstarters by category and percent successful",
         x= "Category", y="Total amout of kickstarters")



#filtering based on regex patterns
kickstarter %>%
  filter(grepl(pattern=" cats? ", name)) %>%
  select(name, state)

#or with stringr
kickstarter %>%
  select_if(is.character) %>%
  filter(str_detect(name, pattern=" cats? "))

#remember that R is case sensitive
kickstarter %>%
  select_if(is.character) %>%
  filter(str_detect(str_to_lower(name), pattern=" cats? "))





#where the word is in any column: name, category, main_category
#no need to select the columns, but increases speed
kickstarter %>%
  select(name, contains("category")) %>%
  filter_all(any_vars(str_detect(., pattern = "fashion"))) %>%
  group_by(category, main_category) %>%
  summarise(n=n())



iris %>% 
  filter_all(any_vars(.>7.5))

#which cat





  


#FILTERING ROWS
kickstarter_data %>%
  count()


kickstarter_data %>%
  group_by(country) %>%
  count()


kickstarter_data %>%
  group_by(country) %>%
  summarise(n=n()) %>%
  arrange(desc(n))



ickstarter



kickstarter %>%
  filter_all(any_vars(. > 1000000))


kickstarter %>%
  filter(between(goal, 1000, 5000)) %>%
  summarise(max=max(goal), min=min(goal))


kickstarter %>%
  select(project = name, goal, pledged) %>%
  filter_all(any_vars(.<5000))

kickstarter %>%
  select(project = name, goal, pledged) %>%
  filter_all(any_vars(.<5000)) %>%
  arrange(goal)

kickstarter %>%
  select(project = name, goal, pledged) %>%
  filter_all(any_vars(.>500000))

kickstarter %>%
  select(project = name, goal, pledged) %>%
  filter(goal > mean(goal))


# The first argument to a filter_if() is the name of a function that will return a TRUE or FALSE 
# based on the column’s contents. 
# The second argument is the type of filter we’ve already written in our filter_all().

kickstarter %>%
  select(name, goal, pledged) %>%
  filter_if(is.numeric, all_vars(.>1000000)) %>%
  mutate(goal = goal/1000000, pledged = pledged/1000000) %>%
  rename(goal_million = goal, pledged_million = pledged)


kickstarter %>%
  select(name, goal, pledged) %>%
  filter_if(is.numeric, any_vars(.>1000000))


kickstarter %>%
  filter_at(vars(contains("category")), any_vars(!is.na(.)))


kickstarter %>%
  filter_at(vars(c("name", "state")), any_vars(!is.na(.)))



kickstarter %>%
  select(state, project=name, everything(), -ID) %>%
  colnames()


kickstarter %>%
  mutate(deadline = date(deadline), 
         launched = date(deadline), 
         year =  year(launched)) %>%
  select(year, main_category, project = name, everything(), -ID)
  

kickstarter %>%
  group_by(main_category) %>%
  slice(1)


iris %>% 
  group_by(Species) %>% 
  arrange(desc(Sepal.Length))


#finding duplicates
iris %>% 
  group_by_all() %>% 
  summarise(nrows=n()) %>%
  arrange(desc(nrows))

kickstarter %>%
  group_by_all() %>% 
  summarise(nrows=n()) %>%
  arrange(desc(nrows))
