# bring in and combine data from https://datagarrison.com/users/300234010412670/300234010412670/temp/Rennell_Pass_017.txt
# time zone is UTC

library(data.table)
library(xts)
library(ggplot2)
library(plotly)
library(dplyr)

path <- "H:/Weather Stations/Data Garrison Stations/Rennell_Pass/"
setwd(path)

df3 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_003.txt", select = 1:10)
df3.xts <- xts(df3[,-1], order.by = as.POSIXct(strptime(df3$Date_Time, format = "%m/%d/%y %H:%M:%S", tz = "UTC"))) 
names <- c('temp', 'rh', 'rain_mm', 'solar_wm2', 'wind_kmhr', 'windMx_kmhr', 'wind_dir', 'sd_m', 'batt')
colnames(df3.xts) <- names

df4 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_004.txt", drop = c(9 ,12)) %>% 
  select(1:8, 10, 9) # reorder to match df3 
df4.xts <- xts(df4[,-1], order.by = as.POSIXct(strptime(df4$Date_Time, format = "%m/%d/%y %H:%M:%S", tz = "UTC")))
names <- c('temp', 'rh', 'rain_mm', 'solar_wm2', 'wind_kmhr', 'windMx_kmhr', 'wind_dir', 'sd_m', 'batt')
colnames(df4.xts) <- names
df5 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_005.txt")
df6 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_006.txt")
df7 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_007.txt")
df8 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_008.txt")
df9 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_009.txt")
df10 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_010.txt")
df11 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_011.txt")
df12 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_012.txt")
df13 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_013.txt")
df14 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_014.txt")
df15 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_015.txt")
df16 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_016.txt")
df17 <- fread("H:/Weather Stations/Data Garrison Stations/Rennell_Pass/Rennell_Pass_017.txt")


merg <- merge(df3.xts, df4.xts)

uniqMerg <- unique(merg
           )

p <- ggplot(df4.xts, aes(x = Index,
                         y = df4.xts[,1])) +
  geom_line()

ggplotly(p)

duplicated()
