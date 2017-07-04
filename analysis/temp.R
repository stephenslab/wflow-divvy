library(ggplot2)
library(data.table)
source("../code/functions.R")
divvy <- read.divvy.data()

stop()

ggplot(divvy$stations,aes(x = longitude,y = latitude)) +
  geom_point(shape = 20,color = "black") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

divvy$stations <-
  cbind(divvy$stations,
    data.frame(departures = as.vector(table(divvy$trips$from_station_id))))

ggplot(divvy$stations,aes(x = longitude,y = latitude,
                          size = sqrt(departures))) +
  geom_point(shape = 21,color = "white",fill = "black") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


