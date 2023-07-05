library(tidyverse)

bikes = read.csv("london_merged.csv")


# Explore the data

table(bikes$weather_code)
table(bikes$season)


## Rename columns to preference
new_col_names = c("time", "count", "temp_real_c", "temp_feels_c", "humidity_pct", 
                  "wind_speed_kph", "weather", "is_holiday", "is_weekend", "season")

colnames(bikes) <- new_col_names

# Humidity values expressed as a pct between 0-1
bikes$humidity_pct = bikes$humidity_pct/100

# Remap the factors within seasona and weather columns
bikes <- bikes %>%
  mutate(season = recode(season, "0.0" = "Spring", "1.0" = "Summer", "2.0" = "Autumn", 
                         "3.0" = "Winter"),
         weather = recode(weather, "1.0" = "clear", "2.0" = "Scattered Clouds", 
                          "3.0" = "Broken Clouds", "4.0" = "Cloudy", "7.0" = "Rain",
                          "10.0" = "Thunder Storm", "26.0" = "Snow"))

# Export our new Excel data for visualization in Tableau
write.csv(bikes, "london_bikes.csv")
