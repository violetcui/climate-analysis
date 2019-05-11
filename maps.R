### This is the stub script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.
library("ggplot2")
library("dplyr")
library("data.table")
library("mapproj")

## read the data
##
## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)
data <- data.table::fread("/opt/data/temp-prec-encrypted.csv.bz2", stringsAsFactors = FALSE)
decryptedData <- decrypt::decryptData(data)

## filter out North American observations
North_America <- filter(decryptedData, latitude >= 10 & latitude <= 90 & longitude >= 200 & longitude <= 300)

## delete the original (large data) from R workspace
## this is necessary to conserve memory.
rm(decryptedData)

## -------------------- do the following for 1960, 1986, 2014 and temp/precipitation --------------------

## select jpg graphics device

## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
## 
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).

## close the device
data_1960 <- North_America %>% filter(time == "1960-04-01")
data_1986 <- North_America %>% filter(time == "1986-04-01")
data_2014 <- North_America %>% filter(time == "2014-04-01")

precipitation <- function(dataset, year) {
  graph1 <- ggplot(data = dataset) + 
    geom_point(mapping = aes(x = longitude, y = latitude, col = precipitation)) +
    labs(title = paste0("Precipitation in April ", year)) +
    coord_map()
  return (graph1)
}

temperature <- function(dataset, year) {
  graph2 <- ggplot(data = dataset) + 
    geom_point(mapping = aes(x = longitude, y = latitude, col = airtemp)) +
    labs(title = paste0("Temperature in April ", year)) +
    coord_map()
  return(graph2)
}

png(file ="1960Precipitation.png", width = 500, height = 500)
precipitation(data_1960, "1960")
dev.off()

png(file ="1986Precipitation.png", width = 500, height = 500)
precipitation(data_1986, "1986")
dev.off()

png(file ="2014Precipitation.png", width = 500, height = 500)
precipitation(data_2014, "2014")
dev.off()

png(file ="1960Temperature.png", width = 500, height = 500)
temperature(data_1960, "1960")
dev.off()

png(file ="1986Temperature.png", width = 500, height = 500)
temperature(data_1986, "1986")
dev.off()

png(file ="2014Temperature.png", width = 500, height = 500)
temperature(data_2014, "2014")
dev.off()
## -------------------- you are done.  congrats :-) --------------------

