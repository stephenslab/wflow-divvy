library(data.table)
library(ggplot2)
source("../code/functions.R")
divvy <- read.divvy.data()

divvy$trips <-
  transform(divvy$trips,
  start.week      = factor(start.week,0:52),
  start.dayofyear = factor(as.numeric(format(divvy$trips$starttime,"%j")),
                           1:366))

counts.day <- as.vector(table(divvy$trips$start.dayofyear))
ggplot(data.frame(day = 1:366,departures = counts.day),
       aes(x = day,y = departures)) +
  geom_point(color = "darkblue",shape = 19,size = 1) +
  geom_line(color = "darkblue") +
  scale_x_continuous(breaks = seq(0,350,25)) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

counts.week <- as.vector(table(divvy$trips$start.week))
ggplot(data.frame(week = 0:52,departures = counts.week),
       aes(x = week,y = departures)) +
  geom_point(color = "darkblue",shape = 19,size = 1.5) +
  geom_line(color = "darkblue") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

dat <- subset(divvy$trips,from_station_name == "University Ave & 57th St")
counts.week.uchicago <- as.vector(table(dat$start.week))
ggplot(data.frame(week = 0:52,departures = counts.week.uchicago),
       aes(x = week,y = departures)) +
  geom_point(color = "darkblue",shape = 19,size = 1.5) +
  geom_line(color = "darkblue") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

