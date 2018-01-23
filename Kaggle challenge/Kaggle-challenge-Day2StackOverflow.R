library(tidyverse)
library(boot)


#Importing file
stackdata <- read_csv("stackoverflow_survey_results_public.csv")


#Creating a database containing people who fit just in either Female or Male to get binomial data (sorry!) and filtering out NA on salary
genderdata <- stackdata %>% 
  filter(Gender == "Female" | Gender == "Male") %>% 
  mutate(Male = Gender=="Male") %>% 
  filter(!is.na(Salary)) %>% 
  filter(Salary > 10000)
genderdata$Gender <- as.factor(genderdata$Gender)
genderdata$Male <- as.integer(genderdata$Male)


#Can I predict Salary based on Gender?
ggplot(genderdata, aes(x=Male, y=Salary))+
  geom_point()+
  geom_smooth(method = "glm", method.args = list(family = "gaussian")) +
  ggtitle("Salary predicted by Gender")

#Checking model fit
model <- glm(Salary ~ Male, data=genderdata, family = gaussian)
glm.diag.plots(model)

#Table data
genderdata %>% 
  group_by(Gender) %>% 
  summarise(n=n(),mean=mean(Salary, na.rm = TRUE), median=median(Salary,na.rm=TRUE))




#Exploring Formal education variable
summary(as.factor(stackdata$FormalEducation))

#Keeping just the bachelors, masters and doctoral degrees, and mutating to a "Have a master degree" variable
keep <- c("Bachelor's degree", "Master's degree", "Doctoral degree")
mastersdegree <-
educationdata <- stackdata %>% 
  filter(FormalEducation %in% keep) %>% 
  filter(Salary > 10000) %>% 
  mutate(Masters = FormalEducation=="Master's degree" | FormalEducation=="Doctoral degree")


#Can I predict Salary based on Gender?
ggplot(educationdata, aes(x=Masters, y=Salary))+
  geom_point()+
  geom_smooth(method = "glm", method.args = list(family = "gaussian")) +
  ggtitle("Salary predicted by Master's degree")

#Checking model fit
model <- glm(Salary ~ Masters, data=educationdata, family = gaussian)
glm.diag.plots(model)

#Table data
educationdata %>% 
  group_by(Masters) %>% 
  summarise(n=n(),mean=mean(Salary, na.rm = TRUE), median=median(Salary,na.rm=TRUE))
