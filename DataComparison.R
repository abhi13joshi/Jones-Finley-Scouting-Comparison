setwd('C:/Users/abhi1/OneDrive/Documents/NCSUSAC/Duke Competition')

#install.packages("rvest")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("hablar")
#install.packages("janitor")
#install.packages("tidyverse")
#install.packages('xml2')
#install.packages('sqldf')
#install.packages("ggthemes")

#included libraries
library('xml2')
library(rvest)
library(dplyr)
library(ggplot2)
library(hablar)
library(janitor)
library(tidyverse)
library(sqldf)
library(ggthemes)

Jones_Stats <- read.csv('Daniel_Jones_College_Stats.csv')
Jones_Game_Log <- read.csv('Daniel_Jones_Game_Log.csv')
Finley_Stats <- read.csv('Ryan_Finley_College_Stats.csv')
Finley_Game_Log <- read.csv('Ryan_Finley_Game_Log.csv')

Jones_Stats
Jones_Game_Log
Finley_Stats
Finley_Game_Log

colnames(Jones_Game_Log) <- c('Game_ID','Year', 'Date', 'School', 'Site', 'Opponent', 'Result','Completions', 
                              'Attempts', 'Pct', 'Pass_Yards', 'Pass_TDs', 'Int', 'Rating',
                              'Rush_Attempts', 'Rush_Yards', 'Rush_Avg', 'Rush_TDs')
colnames(Finley_Game_Log) <- c('Game_ID','Year', 'Date', 'School', 'Site', 'Opponent', 'Result','Completions', 
                               'Attempts', 'Pct', 'Pass_Yards', 'Pass_TDs', 'Int', 'Rating',
                               'Rush_Attempts', 'Rush_Yards', 'Rush_Avg', 'Rush_TDs')
colnames(Jones_Stats) <- c('Season_ID','Year', 'School', 'Conf', 'Class', 'Pos', 
                            'Games', 'Comp', 'Att', 'Pct',
                            'Pass_Yards', 'Yards_Att', 'Adj_Yards_Att',
                            'TD', 'Int', 'Rating')
colnames(Finley_Stats) <- c('Season_ID','Year', 'School', 'Conf', 'Class', 'Pos', 
                            'Games', 'Comp', 'Att', 'Pct',
                            'Pass_Yards', 'Yards_Att', 'Adj_Yards_Att',
                            'TD', 'Int', 'Rating')

view(Jones_Stats)
view(Jones_Game_Log)
view(Finley_Stats)
view(Finley_Game_Log)

Jones_top_five <- head(sqldf("SELECT * FROM Jones_Game_Log ORDER BY Rating DESC;"), n=5)
#view(Jones_top_five)

Finley_top_five <- head(sqldf("SELECT * FROM Finley_Game_Log ORDER BY Rating DESC;"), n=5)
#view(Finley_top_five)

Jones_bottom_five <- head(sqldf("SELECT * FROM Jones_Game_Log ORDER BY Rating ;"), n=5)
#view(Jones_bottom_five)

Finley_bottom_five <- head(sqldf("SELECT * FROM Finley_Game_Log WHERE School = 'North Carolina State'
                                 ORDER BY Rating;"), n=5)
#view(Finley_bottom_five)

Jones_most_accurate <- head(sqldf("SELECT * FROM Jones_Game_Log ORDER BY Pct DESC;"), n=10)
#view(Jones_most_accurate)

Jones_least_accurate <- head(sqldf("SELECT * FROM Jones_Game_Log ORDER BY Pct;"), n=10)
#view(Jones_least_accurate)

Finley_most_accurate <- head(sqldf("SELECT * FROM Finley_Game_Log WHERE School = 'North Carolina State' ORDER BY Pct DESC;"), n=10)
#view(Finley_most_accurate)

Finley_least_accurate <- head(sqldf("SELECT * FROM Finley_Game_Log WHERE School = 'North Carolina State' ORDER BY Pct;"), n=10)
#view(Finley_least_accurate)

Jones_Averages <- sqldf("SELECT AVG(Completions), AVG(Attempts), AVG(Pct), AVG(Pass_Yards), AVG(Pass_TDs), AVG(Int), AVG(Rating),
                              AVG(Rush_Attempts), AVG(Rush_Yards), AVG(Rush_Avg), AVG(Rush_TDs)  FROM Jones_Game_Log;")
#view(Jones_Averages)

Finley_Averages <- sqldf("SELECT AVG(Completions), AVG(Attempts), AVG(Pct), AVG(Pass_Yards), AVG(Pass_TDs), AVG(Int), AVG(Rating),
                              AVG(Rush_Attempts), AVG(Rush_Yards), AVG(Rush_Avg), AVG(Rush_TDs)  FROM Finley_Game_Log;")
#view(Finley_Averages)

#Jones_Game_Log=data.frame(value=rnorm(100))

# basic histogram
Jones_Range <- ggplot(Jones_Game_Log, aes(x=Rating)) + geom_histogram()
#view(Jones_Range)

Jones_Range <- ggplot(data = Jones_Game_Log, mapping = aes(Rating)) + geom_histogram(binwidth = 10)
Jones_Range

plot <- ggplot(Jones_Game_Log, aes(as.numeric(Attempts), as.numeric(Pct))) + geom_boxplot()  
plot 

Jones_Rating <- ggplot(Jones_Game_Log, aes(x=as.numeric(Rating))) + geom_histogram(binwidth = 50)  
Jones_Rating

Finley_Rating <- ggplot(Finley_Game_Log, aes(x=as.numeric(Rating))) + geom_histogram(binwidth = 50)  
Finley_Rating

Jones_ACC <- sqldf("SELECT * FROM Jones_Game_Log WHERE 
                   Opponent = 'Boston College' OR
                   Opponent = 'Clemson' OR
                   Opponent = 'Florida State' OR 
                   Opponent = 'Louisville' OR
                   Opponent = 'Miami (FL)' OR
                   Opponent = 'North Carolina State' OR
                   Opponent = 'Notre Dame' OR
                   Opponent = 'Syracuse' OR
                   Opponent = 'Wake Forest' OR
                   Opponent = 'Georgia Tech' OR
                   Opponent = 'North Carolina' OR
                   Opponent = 'Pittsburgh' OR
                   Opponent = 'Virginia' OR
                   Opponent = 'Virginia Tech'
                   ORDER BY Date")
Jones_ACC
#view(Jones_ACC)

Finley_ACC <- sqldf("SELECT * FROM Finley_Game_Log WHERE 
                   Opponent = 'Boston College' OR
                   Opponent = 'Clemson' OR 
                   Opponent = 'Florida State' OR 
                   Opponent = 'Louisville' OR
                   Opponent = 'Miami (FL)' OR
                   Opponent = 'Duke' OR
                   Opponent = 'Notre Dame' OR
                   Opponent = 'Syracuse' OR
                   Opponent = 'Wake Forest' OR
                   Opponent = 'Georgia Tech' OR
                   Opponent = 'North Carolina' OR
                   Opponent = 'Pittsburgh' OR
                   Opponent = 'Virginia' OR
                   Opponent = 'Virginia Tech'
                   ORDER BY Date")
Finley_ACC
#view(Finley_ACC)

#write.csv(Finley_ACC, 'Ryan_Finley_ACC_Stats.csv')
#write.csv(Jones_ACC, 'Daniel_Jones_ACC_Stats.csv')

theme_set(theme_bw())

df <- rbind(Jones_ACC, Finley_ACC)
view(df)

#plot
Efficiency <- ggplot(df,
                    aes(x = Pct,
                        y = Rating, color = School)) + 
  geom_point(position = "jitter") + scale_color_manual(name = 'Quarterback', 
                                                       labels = c('Daniel Jones', 'Ryan Finley'),
                                                         values=c('#003087','#CC0000')) +
  labs(title = "Jones & Finley vs ACC Opponents", 
       x = "Completion Percentage", 
       y = "Passer Rating", 
       caption = "Data Viz by Brandon Wisniewski, Abhi Joshi, Pat Walther, Connor Stephens & Robbie Goss ~ Data from Sports Reference",
       fill = "Quarterbacks") +
   theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5)) +
  scale_fill_identity() 

Efficiency

#ggsave(filename = 'Efficiency_Comparison.png', plot = Efficiency)