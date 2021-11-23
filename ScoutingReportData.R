#install.packages("rvest")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("hablar")
#install.packages("janitor")
#install.packages("tidyverse")
#install.packages('xml2')
#install.packages('sqldf')

#included libraries
library('xml2')
library(rvest)
library(dplyr)
library(ggplot2)
library(hablar)
library(janitor)
library(tidyverse)
library(sqldf)

#Daniel Jones Stats

Jones_Stats <- "https://www.sports-reference.com/cfb/players/daniel-jones-4.html"

url <- Jones_Stats
pageobj <- read_html(url, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(fill=T) -> Jones_Stats

Jones_Stats <- row_to_names(Jones_Stats, 1, remove_row = TRUE, remove_rows_above = FALSE)

Jones_Stats <- clean_names(Jones_Stats)
names(Jones_Stats)
Jones_Stats
colnames(Jones_Stats) <- c('Year', 'School', 'Conf', 'Class', 'Pos', 
                           'Games', 'Comp', 'Att', 'Pct',
                           'Pass Yards', 'Yards/Att', 'Adj Yards/Att',
                           'TD', 'Int', 'Rating')


Jones_Stats['Year'][Jones_Stats['Year'] == "*2015"] <- "2015"
Jones_Stats['Year'][Jones_Stats['Year'] == "*2017"] <- "2017"
Jones_Stats['Year'][Jones_Stats['Year'] == "*2018"] <- "2018"

view(Jones_Stats)


Jones_Game_Log <- "https://www.sports-reference.com/cfb/players/daniel-jones-4/gamelog/"

url <- Jones_Game_Log
pageobj <- read_html(url, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(fill=T) -> Jones_Game_Log

Jones_Game_Log <- row_to_names(Jones_Game_Log, 1, remove_row = TRUE, remove_rows_above = FALSE)

Jones_Game_Log <- clean_names(Jones_Game_Log)
names(Jones_Game_Log)




Jones_Game_Log <- Jones_Game_Log[ -c(1,19:30) ]
colnames(Jones_Game_Log) <- c('Year', 'Date', 'School', 'Site', 'Opponent', 'Result','Completions', 
                              'Attempts', 'Pct', 'Pass Yards', 'Pass TDs', 'Int', 'Rating',
                              'Rush Attempts', 'Rush Yards', 'Rush Avg', 'Rush TDs')
Jones_Game_Log<-Jones_Game_Log[!(Jones_Game_Log$Year=="Year" | Jones_Game_Log$Attempts=="Passing"
                               | Jones_Game_Log$Date=="36 Games") ,]


Jones_Game_Log['Opponent'][Jones_Game_Log['Opponent'] == "Northern Illinois*"] <- "Northern Illinois"
Jones_Game_Log['Opponent'][Jones_Game_Log['Opponent'] == "Temple*"] <- "Temple"

view(Jones_Game_Log)

#write.csv(Jones_Stats, 'Daniel_Jones_College_Stats.csv')
#write.csv(Jones_Game_Log, 'Daniel_Jones_Game_Log.csv')



#Ryan Finley Stats

Finley_Stats <- "https://www.sports-reference.com/cfb/players/ryan-finley-1.html"

url <- Finley_Stats
pageobj <- read_html(url, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(fill=T) -> Finley_Stats

Finley_Stats <- row_to_names(Finley_Stats, 1, remove_row = TRUE, remove_rows_above = FALSE)

Finley_Stats <- clean_names(Finley_Stats)
names(Finley_Stats)
colnames(Finley_Stats) <- c('Year', 'School', 'Conf', 'Class', 'Pos', 
                           'Games', 'Comp', 'Att', 'Pct',
                           'Pass Yards', 'Yards/Att', 'Adj Yards/Att',
                           'TD', 'Int', 'Rating')

Finley_Stats['Year'][Finley_Stats['Year'] == "*2014"] <- "2014"
Finley_Stats['Year'][Finley_Stats['Year'] == "*2015"] <- "2015"
Finley_Stats['Year'][Finley_Stats['Year'] == "*2016"] <- "2016"
Finley_Stats['Year'][Finley_Stats['Year'] == "*2017"] <- "2017"
Finley_Stats['Year'][Finley_Stats['Year'] == "*2018"] <- "2018"
view(Finley_Stats)


Finley_Game_Log <- "https://www.sports-reference.com/cfb/players/ryan-finley-1/gamelog/"

url <- Finley_Game_Log
pageobj <- read_html(url, as.data.frame=T, stringsAsFactors = TRUE)

pageobj %>%  
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table(fill=T) -> Finley_Game_Log

Finley_Game_Log <- row_to_names(Finley_Game_Log, 1, remove_row = TRUE, remove_rows_above = FALSE)

Finley_Game_Log <- clean_names(Finley_Game_Log)
names(Finley_Game_Log)


Finley_Game_Log <- Finley_Game_Log[ -c(1,19:22) ]
colnames(Finley_Game_Log) <- c('Year', 'Date', 'School', 'Site', 'Opponent', 'Result','Completions', 
                               'Attempts', 'Pct', 'Pass Yards', 'Pass TDs', 'Int', 'Rating',
                               'Rush Attempts', 'Rush Yards', 'Rush Avg', 'Rush TDs')

Finley_Game_Log<-Finley_Game_Log[!(Finley_Game_Log$Year=="Year" | Finley_Game_Log$Attempts=="Passing"
                                 | Finley_Game_Log$Date=="46 Games") ,]

Finley_Game_Log['Opponent'][Finley_Game_Log['Opponent'] == "Vanderbilt*"] <- "Vanderbilt"
Finley_Game_Log['Opponent'][Finley_Game_Log['Opponent'] == "Arizona State*"] <- "Arizona State"
Finley_Game_Log['Opponent'][Finley_Game_Log['Opponent'] == "Texas A&M*"] <- "Texas A&M"

view(Finley_Game_Log)

#write.csv(Finley_Stats, 'Ryan_Finley_College_Stats.csv')
#write.csv(Finley_Game_Log, 'Ryan_Finley_Game_Log.csv')



