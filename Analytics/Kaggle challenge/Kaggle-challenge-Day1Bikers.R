library(tidyverse)
library(stringr)
library(boot)


#Importing the data
bikers <- read_csv("nyc-east-river-bicycle-counts.csv")


#Understanding the data
summary(bikers)
glimpse(bikers)
colnames(bikers)


#Cleaning the data: removing values with " (S)", turning into numeric will change "T" no NA
bikers$Precipitation <- str_replace(bikers$Precipitation, "\\(S\\)", "")
bikers$Precipitation <- as.numeric(bikers$Precipitation)


#Can I predict the numbers of bikers based on minimum Temperature?
ggplot(bikers, aes(x=`Low Temp (°F)`, y=Total))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Total bikers versus Minimum Temperature")

#diagnostic plots
modelLT <- glm(Total~`Low Temp (°F)`, data=bikers, family="poisson")
glm.diag.plots(modelLT)


#Can I predict the numbers of bikers based on maximum Temperature?
ggplot(bikers, aes(x=`High Temp (°F)`, y=Total))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Total bikers versus Maximum Temperature")

#diagnostic plots
modelHT <- glm(Total~`High Temp (°F)`, data=bikers, family="poisson")
glm.diag.plots(modelHT)


#Can I predict the numbers of bikers based on precipitation?
#Remove NA rows
bikers_exclPrNA <- na.omit(bikers)

ggplot(bikers_exclPrNA, aes(x=Precipitation, y=Total))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Total bikers versus Precipitation")

#diagnostic plots
modelPC <- glm(Total~Precipitation, data=bikers, family="poisson")
glm.diag.plots(modelPC)



#As maxiumum temperature looks like the best estimate:
#For brooklyn bridge
ggplot(bikers, aes(x=`High Temp (°F)`, y=`Brooklyn Bridge`))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Brooklyn Bridge")

#For manhattan bridge
ggplot(bikers, aes(x=`High Temp (°F)`, y=`Manhattan Bridge`))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Manhattan Bridge")

#For williamsburg bridge
ggplot(bikers, aes(x=`High Temp (°F)`, y=`Williamsburg Bridge`))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Williamsburg Bridge")

#For queensboro bridge
ggplot(bikers, aes(x=`High Temp (°F)`, y=`Queensboro Bridge`))+
  geom_point(size=0)+
  geom_smooth(method = "glm", method.args = list(family = "poisson"), size = 0) +
  ggtitle("Queensboro Bridge")
