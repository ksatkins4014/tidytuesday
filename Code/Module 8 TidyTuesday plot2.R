########################################################################################
# Summary: TidyTuesday Module 8 Plot 2 "Meteorite Observations from 1995-2013"
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


#### Filter data for year 1995-2013
Meteorite_impacts %>%
  filter(year >= 1995) %>%
  filter(year <= 2013) %>%
  ##### Select items of interest
  select(id, `Hemisphere`, year) %>%
  ##### Count Observations for each hemisphere, for each year over the time span
  count(year, Hemisphere) -> Impacts_post1995


#### Visualize data with a stacked bar chart
Impacts_post1995 %>%
  ggplot(mapping = aes(year, n, fill = Hemisphere)) +
  scale_fill_manual(values = c("firebrick", "royalblue"))+
  geom_bar(stat = "identity") +
  labs( title = "Meteorite Observations from 1995-2013", 
        x = "Year", 
        y = "Number of Observations") +
  labs(fill = "Hemisphere Observation Occurred") +
  theme(legend.position = "bottom")

