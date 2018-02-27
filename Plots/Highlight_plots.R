library(tidyverse)

###
#HIGHLIGHT PLOTS
###


#one chick
ggplot() +
  geom_line(data=ChickWeight, aes(x=Time, y=weight, group=Chick), color = "gray") +
  geom_line(data=subset(ChickWeight, Chick==17), 
            aes(x=Time, y=weight, group=Chick), color = "red", size = 1) +
  labs(title = "Weight of Chicks 17 versus other chicks")



#three chicks
selected_chicks <- ChickWeight %>% 
  filter(Chick %in% c(15, 16, 17))

ggplot(data=ChickWeight, aes(x=Time, y=weight, group=Chick)) +
  geom_line(color = "gray") +
  geom_line(data=selected_chicks, aes(color = Chick), size = 1) +
  labs(title = "Weight of Chicks 15, 16, 17 versus other chicks")
