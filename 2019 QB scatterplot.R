library(tidyverse)
library(ggplot2)
library(rvest)
library(dplyr)
library(readxl)
library(ggrepel)

install.packages(ggrepel)
#Import Excel File
X2019qbtable <- read_excel("C:\\Users\\brand\\OneDrive\\Documents\\SAC\\2019qbtable.xlsx")
View(X2019qbtable)

#add hex colors of respective college teams to each QB
color <- c("#841617","#003087","#BB0000", "#F1B82D", '#002855', "#CC0000", 
           "#E87722", "#0A5640", "#4E2A84", "#5E6A71", "#041E42")

X2019qbtable$color <- color

#Make Plot
QBScatter <- ggplot(X2019qbtable,
                    aes(x = Pct,
                        y = Rating,
                        color = Name)) + 
  geom_jitter() +
  geom_label_repel(aes(label = Name, fill = color),color = "white",
             size = 6, fontface = "bold") +
  scale_x_continuous(breaks = seq(40, 100, by = 5)) +
  scale_y_continuous(breaks = seq(100, 200, by = 15)) +
  labs(title = "QB Efficiency 2019 Draft Class", 
       x = "Completion Percentage", 
       y = "Passer Rating", 
       caption = "Data Viz by Brandon Wisniewski, Abhi Joshi, Pat Walther, Connor Stephens. and Robbie Goss ~ Data from SportsReference") +
  theme_dark() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5)) +
  scale_fill_identity() +
  scale_color_manual(values = c("Kyler Murray" = "#841617", 
                                "Daniel Jones" = "#003087", 
                                "Dwayne Haskins" = "#BB0000", 
                                "Drew Lock" = "#F1B82D",
                                "Will Grier" = "#002855",
                                "Ryan Finley" = "#CC0000",
                                "Jarrett Stidham" = "#E87722",
                                "Easton Stick" = "#0A5640", 
                                "Clayton Thorson" = "#4E2A84", 
                                "Gardner Minshew" = "#5E6A71", 
                                "Trace McSorley" = "#041E42"))

QBScatter


