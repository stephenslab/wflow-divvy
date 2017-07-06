library(data.table)
library(ggplot2)
source("../code/functions.R")
divvy <- read.divvy.data()
divvy$trips <- transform(divvy$trips,
                         start.hour = factor(start.hour,0:23))
ggplot(divvy$trips,aes(start.hour)) +
  geom_bar(fill = "black",width = 0.6) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
    
ggplot(divvy$trips,aes(start.hour)) +
  geom_bar(fill = "black",width = 0.6) +
  facet_wrap(~start.day,ncol = 2) +
  scale_x_discrete(breaks = seq(0,24,2)) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
       
ggplot(subset(divvy$trips,from_station_name == "University Ave & 57th St"),
       aes(start.hour)) +
  geom_bar(fill = "black",width = 0.6) +
  facet_wrap(~start.day,ncol = 2) +
  scale_x_discrete(breaks = seq(0,24,2)) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
       
