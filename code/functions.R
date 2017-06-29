# This file defines some functions that are used in the R Markdown
# notebooks in the "analysis" directory.

# TO DO: Explain here what this function does, and how to use it.
read.divvy.data <-
  function (trip.files = c("../data/Divvy_Trips_2016_Q1.csv",
                           "../data/Divvy_Trips_2016_04.csv",
                           "../data/Divvy_Trips_2016_05.csv",
                           "../data/Divvy_Trips_2016_06.csv",
                           "../data/Divvy_Trips_2016_Q3.csv",
                           "../data/Divvy_Trips_2016_Q4.csv"),
            station.file = "../data/Divvy_Stations_2016_Q4.csv") {

  # Load the station data.
  cat("Reading station data from ",station.file,".\n",sep="")
  stations <- fread("../data/Divvy_Stations_2016_Q4.csv",sep = ",",
                    header = TRUE,stringsAsFactors = FALSE,verbose = FALSE,
                    showProgress = FALSE)
  class(stations) <- "data.frame"

  # Combine trip data into a single table.
  n     <- length(trip.files)
  trips <- NULL
  for (i in 1:n) {
    cat("Reading trip data from ",trip.files[i],".\n",sep="")
    x        <- fread(trip.files[i],sep = ",",header = TRUE,
                      stringsAsFactors = FALSE,verbose = FALSE,
                      showProgress = FALSE)
    class(x) <- "data.frame"
    trips    <- rbind(trips,x)
  }

  # Set some of the table columns to factors.
  cat("Preparing Divvy data for analysis in R.\n")
  trips <-
    transform(trips,
              usertype          = factor(usertype),
              gender            = factor(gender),
              bikeid            = factor(bikeid),
              from_station_id   = factor(from_station_id,stations$id),
              to_station_id     = factor(to_station_id,stations$id),
              from_station_name = factor(from_station_name,stations$name),
              to_station_name   = factor(to_station_name,stations$name))

  # Set the row names in the station table to the station id.
  rownames(stations) <- stations$id
  stations           <- stations[-1]
  
  # Return a list object containing the station data and the trip
  # data.
  return(list(stations = stations,trips = trips))
}
