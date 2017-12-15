library(tidyverse)

#####################
#REORDERING BARPLOTS#
#####################


#simple example: dataframe with 1 unordered and one ordered factor
list <- c("Fig", "Banana", "Citrus", "Dragonfruit", "Elderberry", "Apple")
levels <-list[order(nchar(list))]
unordered_col <- factor(sample(list, 50, replace=TRUE))
ordered_col <- factor(unordered_col, levels=levels, ordered=TRUE)
recently_unordered_col <- factor(ordered_col, ordered=TRUE)
unfactored_col <- as.vector(ordered_col)
fruit <- data.frame(ordered_col, unordered_col, recently_unordered_col, unfactored_col, stringsAsFactors = FALSE)
glimpse(fruit)

#Barplot of ordered arranges it alphabetically
fruit %>%
  ggplot(aes(x=unordered_col))+
  geom_bar()

#Barplot of urdered arranges it according to the levels
fruit %>%
  ggplot(aes(x=ordered_col), f)+
  geom_bar()

#Barplot of the factor that was unordered keeps its levels
a <- fruit %>%
  ggplot(aes(x=recently_unordered_col))+
  geom_bar()

#Barplot of the string character
b <- fruit %>%
  ggplot(aes(x=unfactored_col))+
  geom_bar()

#plotting together
library(cowplot)
plot_grid(a,b)

#All 4 together
fruit%>%
  
  ggplot()

#Check the underlying levels
levels(unordered_col)
levels(ordered_col)
levels(recently_unordered_col)
levels(unfactored_col)


#Getting the scheme that will allow us to manipulate

#Changing the order cannot be overwritten with the arrange function
fruit %>%
  count(unordered_col) %>% 
  arrange(desc(n)) %>%
  ggplot(aes(x=unordered_col,n))+
    geom_col()


#Using reorder for descending barplot  
fruit %>%
  count(unordered_col) %>% 
  mutate(unordered_col = reorder(unordered_col, -n)) %>%
  ggplot(aes(x=unordered_col,n))+
  geom_col()


#or without creating a new variable but using forcats package

diamonds %>%
  count(clarity) %>%
  mutate(percent = n / sum(n)) %>%
  ggplot(aes(x = fct_reorder(clarity, -percent), y = percent)) +
  geom_bar(stat = "identity") +
  scale_y_continuous("Proportion", labels = scales::percent)




##################
#DIAMONDS SECTION#
##################

glimpse(diamonds)



#standard ggplot with the database piped in
diamonds %>%
  ggplot(aes(x=carat, y=price, col=cut))+
  geom_point()

#of filtering on another variable
diamonds %>%
  filter(cut %in% c("Fair", "Good"))%>%
  ggplot(aes(x=carat, y=price, col=cut))+
    geom_point()

#can filter inside the pipe on a completely different variable as well of course
diamonds %>%
  filter(color=="E")%>%
  ggplot(aes(x=carat, y=price, col=cut))+
  geom_point()

#do any other dplyr actions
################## WORK ON THIS #################
diamonds %>%
  mutate(PriceVsMin = price - min(price))%>%
  ggplot(aes(x=carat, y=price, col=cut))+
  geom_point()



#standard barplot: when ordered factor takes the order as prescriped
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

#changing the plot to the piped version
diamonds%>%
  ggplot(aes(x=cut))+
    geom_bar()


#when onordered factor its order is alphabetically
diamonds$unorderedCut <- factor(diamonds$cut, ordered=FALSE)
glimpse(diamonds)
diamonds%>%
  ggplot(aes(x=unorderedCut))+
  geom_bar()




#previous can't be changed in descending order
#barplots based on counts of variable cut
diamonds%>%
  count(clarity)%>%
  ggplot(aes(x=clarity, y=n))+
    geom_bar(stat="identity")

#Descending arrange does not change the plot

diamonds2%>%
  count(clarity)%>%
  arrange(desc(n))%>%
  ggplot(aes(x=clarity, y=n))+
  geom_bar(stat="identity")

glimpse(diamonds)
diamonds2 <- diamonds
diamonds2$clarity <- factor(diamonds2$clarity, ordered=FALSE)
glimpse(diamonds2)





#Enter the forcats package
diamonds %>%
  count(cut) %>%
  ggplot(aes(x = fct_reorder(cut, n), y = n)) +
  geom_bar(stat = "identity")

