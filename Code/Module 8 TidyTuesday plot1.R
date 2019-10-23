########################################################################################
# Summary: TidyTuesday Module 8 Plot 1 "Meteorite Distribution Data"
# Date: October 18 2019
#Author: Kelsey Atkins
########################################################################################


# Clear workspace & load packages ----
rm(list = ls(all = TRUE))
library(tidyverse)
library(stringr)
library(lubridate)
library(forcats)
library(dplyr)
library(maps)

####Read & inspect the dataset ----

Meteorite_impacts <- read_csv("data/2019/2019-06-11/meteorites.csv")

#### inspection including: str(), head(), tail(), dim(), and external data source summary using Summary()
str(Meteorite_impacts)
head(Meteorite_impacts)
tail(Meteorite_impacts)
dim(Meteorite_impacts)
summary(Meteorite_impacts)
view(Meteorite_impacts)

#### Drop NA values that don't specify coordinates, separate Northern/Southern Hemisphere Observations

Meteorite_impacts %>%
  drop_na(long,lat) %>%
  mutate("Hemisphere" = ifelse(lat > 0,
                               "Northern", 
                               "Southern")) -> Meteorite_impacts

#### Factor 'Hemisphere' column, specify levels

Meteorite_impacts$`Hemisphere` <- factor(Meteorite_impacts$`Hemisphere`,
                                                           levels = c("Northern",
                                                                      "Southern"))

##### Obtain World map dataset
World_map <- map_data("world") 


#### Plot world Map, add a horizontal line at latitude = 0 to clearly separate hemispheres
World_map %>%
  ggplot(mapping = aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  geom_hline(yintercept = 0, color = "red4", size = 1.2) +
  scale_x_continuous(limits = c(-180,180)) +
  labs( title = "Meteorite Observation Distribution Map", 
        x = "Longitude", 
        y = "Latitude") +
##### Layer Meteorite Observation data atop the world map by longitude, latitude and hemisphere
  geom_point(data = Meteorite_impacts, aes(long, lat, color = Hemisphere), 
             size = 0.001,
             inherit.aes = FALSE) + 
  scale_color_manual(values = c("springgreen","royalblue")) +
  theme(legend.position = "bottom") +
  labs(color = "Observation Location by Hemisphere") -> Meteor_impact_map

Meteor_impact_map               
  
  





