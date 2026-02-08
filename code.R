library(dplyr)
vgsales<- read.csv('vgsales.csv')
View (vgsales)
#to know what years are contained in a specific column
unique(vgsales$Year)

#1. learning dply verbs : filter() note: subsets data based on provided conditions
vgsales %>% 
  filter(Year == 2003, Publisher == 'Nintendo')

#2. arrange () note: sorts data by ascending order 9default) or descending order (use desc() around the variable being sorted by)

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
  arrange 

#Data Visualisation with ggplot2
library (ggplot2)
vgsales_2003 <- vgsales%>%
  filter (Year == 2003, Global_Sales > 1.5)

#creating a scatterplot to visualize the relationship between Publishers and their Global Sales in 2003
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales)) + geom_point()

#adding color to the plot
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales, color = Genre)) + geom_point()

#adding size aesthetic to the plot
ggplot(vgsales_2003, aes(x=Publisher, y=Global_Sales, color = Genre, size= EU_Sales)) + geom_point()
