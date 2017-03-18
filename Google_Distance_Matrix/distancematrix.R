##This script uses the gmapsdistance package to compute distances between two sets of points
##Before starting, get an API from Google Matrix: https://developers.google.com/maps/documentation/distance-matrix/intro
##Google provides 2,500 queries for free each day, though you can pay for more.
##See the usage limits here: https://developers.google.com/maps/documentation/distance-matrix/usage-limits

##Also make sure that the addresses do not have spaces--use + to separate elements

install.packages("gmapsdistance")
install.packages("tidyverse")
library(gmapsdistance)
library(tidyverse)
#Distance_matrix<-read_csv("Distance matrix.csv") #Download this file from the course website
#set.api.key("##YOURKEYHERE##") #Use when needed for billing

#We will use the gmapsdistance function. Read more about it.
?gmapsdistance

#Request the distance matrix
results = gmapsdistance(origin = Distance_matrix$From, #Use the "From" column
                        destination = Distance_matrix$WH, #Use the "WH" column
                        mode = "driving", #Other driving modes are walking, transit, bicycling
                        shape="long") #Return the results as one long list
results.df<-data.frame(results) #Change the results to a data frame you can see

#Filter the dataset so only the locations with the lowest times are visible
results.min<-results.df %>% #Specify the dataset
              group_by(Time.or) %>% #Group by starting location
              summarise(Time.Time=min(Time.Time)) %>% #Identifying the minimum time
              left_join(results.df) %>% #Join in destination information
              filter(!is.na(Time.or)) #Get rid of other choices that aren't the minimum

#You can also use lat/long.
#Which waffle House is closest to the Geography building?
results = gmapsdistance(origin = "33.948509+-83.374052", #Use the "From" column
                        destination = Distance_matrix$WH, #Use the "WH" column
                        mode = "driving", #Other driving modes are walking, transit, bicycling
                        shape="long") #Return the results as one long list
results.df<-data.frame(results) #Change the results to a data frame you can see
