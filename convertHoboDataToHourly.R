# a script to resample 15 min interval HOBO logger data to 1 hour averages 
library(xts)
library(dplyr)
library(chron)

path = 'H:/FLNRO/Russell Creek/Data/'
setwd(path)

apply.hourly <- function(x, FUN,...) {
  ep <- endpoints(x, 'hours')
  period.apply(x, ep, FUN, ...)
}

df <- read.csv('Steph 1/Steph_1 hobo data_2010 to 2014.csv') %>% 
  slice(1:10000)

df <- read.zoo(df, index = 2:3, format = "%m/%d/%Y %H:%M", tz = "UTC") 

# if duplicate date + times take last entry
df <- aggregate(df, index(df), tail, 1)

ts <- as.xts(df)
 gsdf afg
df.hourly <-  apply.hourly(ts, mean)



