#Learning Tidyverse
library(dplyr)
vgsales<- read.csv('vgsales.csv')
View (vgsales)
#to know what years are contained in a specific column
unique(vgsales$Year)

#1. learning dplyr verbs : filter() note: subsets data based on provided conditions
vgsales %>% 
  filter(Year == 2003, Publisher == 'Nintendo')

#2. arrange () note: sorts data by ascending order (default) or descending order (use desc() around the variable being sorted by)

vgsales %>% 
  arrange (Global_Sales) 

#3. to filter then arrange 
vgsales %>%
  filter (Year== 2003, Publisher == 'Nintendo') %>%
  arrange (Global_Sales)

#4. mutate () note: used to manipulate variables or add variables
vgsales %>%
  mutate (Global_Sales= Global_Sales * 100)
#to add a variable
vgsales %>%
  mutate (Global_Sales2 = Global_Sales * 100)

#5. combining the verbs learned so far
vgsales %>%
  mutate (Global_Sales2 = Global_Sales * 100)%>%
  filter (Year == 2003, Publisher == "Nintendo") %>%
  arrange (desc(Global_Sales2))


#the summarize () verb - used to turn or summarize many rows into one
vgsales %>%
  filter (Year == 2003) %>%
  summarize (meanGlobalSales = mean(Global_Sales), 
             totalGlobalSales = sum(Global_Sales))

#the group_by () verb - used to get subsets in groups

vgsales %>% 
  group_by (Year)%>%
  summarise(meanGlobalSales = mean(Global_Sales), 
            totalGlobalSales = sum(Global_Sales))

# using summarize () to find the name of the game with the max Europe sales in 2003
vgsales %>%
  filter (Year == 2003)%>%
  group_by (Publisher)%>%
  summarize(max(Name), max(EU_Sales))



#Data Visualization with ggplot2
library (ggplot2)
vgsales_2003 <- vgsales%>%
  filter (Year == 2003, Global_Sales > 3.8)

#creating a scatterplot to visualize the relationship between Publishers and their Global Sales in 2003
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales)) + geom_point()

#adding color to the plot
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales, color = Genre)) + geom_point()

#adding size aesthetic to the plot
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales, color = Genre, size= EU_Sales)) + geom_point()

#faceting 
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales, color = Genre, size= EU_Sales)) + geom_point() + facet_wrap(~Platform)

#visualizing summarized data
#1. Best Selling Game Globally per Genre in 2003(scatterplot)
by_genre <- vgsales %>%
  filter (Year == 2003)%>%
  group_by (Genre)%>%
  summarize(gameName= max(Name),globalSales= max(Global_Sales))

ggplot(by_genre, aes(x=Genre, y=globalSales, color = gameName)) + geom_point () + labs(title='Best Selling Game Globally per Genre in 2003',
              caption= 'Data source: Kaggle(vgsales)')

#.2. Total Sales per Genre in 2010(boxplot)
by_genre <- vgsales %>%
  filter (Year == 2010)%>%
  group_by (Genre)%>%
  summarize(gameName= max(Name),Global_Sales)

ggplot(by_genre, aes(x=Genre, y=Global_Sales)) + geom_boxplot () + labs(title='Total Sales per Genre in 2010',
                                                                                       caption= 'Data source: Kaggle(vgsales)') + scale_y_log10()
#3. Individual Sales per Publisher in North American (2002)- histogram
 by_platform <- vgsales %>%
   filter (Year==2002)%>%
   group_by (Platform) %>%
   summarize (NaSales= NA_Sales*10)
 
 ggplot(by_platform, aes(x=NaSales)) + geom_histogram(binwidth = 2)
 
#4. 
 
 
 
 
 #----- PROBABILITY-----
 vgsales %>%
   sample_n(1)
 #setting a seed
 set.seed(21)
 vgsales %>%
   sample_n(1)
 #sampling with or without replacement
 vgsales %>%
   sample_n (2,replace=TRUE)
 