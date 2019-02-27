library(dplyr)
library(ggplot2)
library(lubridate)


# a script that utilizes a campbell sci's R function to import TOA5 files from: https://www.campbellsci.eu/blog/tool-to-import-data-to-r
path = 'H:/FLNRO/Russell Creek/Data/'
setwd(path)

# bring in required functions 
importCSdata <- function(filename,RetOpt="data"){
  if(RetOpt=="info"){
    # bring in entire header of CSI TOA5 data file for metadata
    stn.info <- scan(file=filename,nlines=4,what=character(),sep="\r")
    return(stn.info)
  } else {
    # second line of header contains variable names
    header <- scan(file=filename,skip=1,nlines=1,what=character(),sep=",")
    # bring in data
    stn.data <- read.table(file=filename,skip=4,header=FALSE, na.strings=c("NAN"),sep=",")
    names(stn.data) <- header
    # add column of R-formatted date/timestamps
    stn.data$TIMESTAMP <- as.POSIXct(strptime(stn.data$TIMESTAMP,"%Y-%m-%d %H:%M:%S"))
    return(stn.data)}
}

##### Steph 1 ####


# read in russell campbell sci data and append 
dat1.1 <- read.csv('Steph 1/RussellCreekWX_Hourly 1.csv', skip = 1) %>% 
  filter(is.numeric(RECORD))

dat1.2 <- read.csv('Steph 1/RussellCreekWX_Hourly 2.csv', skip = 1)

dat1 <- dat1.1 %>% 
  # full join to keep all data from offset records
  full_join(dat1.2, by = 'TIMESTAMP') 





dat1.1 <- importCSdata('Steph 1/Steph 1_Hourly1.dat')

dat1.2 <- importCSdata('Steph 1/Steph 1_Hourly2.dat')

dat1 <- dat1.1 %>% 
  # full join to keep all data from offset records
  full_join(dat1.2, by = 'TIMESTAMP') 

dat2.1 <- importCSdata('Steph 1/Steph_1_Hourly1_11-29-2018.dat')

dat2.2 <- importCSdata('Steph 1/Steph_1_Hourly2_11-29-2018.dat')

dat2 <- dat2.1 %>% 
  # full join to keep all data from offset records
  full_join(dat2.2, by = 'TIMESTAMP') 

dat3.1 <- importCSdata('Steph 1/Steph 1 Hourly1_2019-01-22T11-36.dat')

dat3.2 <- importCSdata('Steph 1/Steph 1 Hourly2_2019-01-22T11-36.dat')

dat3 <- dat3.1 %>% 
  # full join to keep all data from offset records
  full_join(dat3.2, by = 'TIMESTAMP') 

##### Steph 2 ####
# read in russell campbell sci data and append 
dat1.1 <- importCSdata('Steph 2/Steph2_direct_Hourly1_20180215.dat')

dat1.2 <- importCSdata('Steph 2/Steph2_direct_Hourly2_20180215.dat')

dat1 <- dat1.1 %>% 
  inner_join(dat1.2, by = 'TIMESTAMP') %>% 
  # Filter to prevent overlap
  filter(TIMESTAMP < as.POSIXct("2018-01-12 23:00:00"))

dat2.1 <- importCSdata('Steph 2/Steph 2_Hourly1.dat') 

dat2.2 <- importCSdata('Steph 2/Steph 2_Hourly2.dat')

dat2 <- dat2.1 %>% 
  inner_join(dat2.2, by = 'TIMESTAMP') %>% 
  # Filter to prevent overlap
  filter(TIMESTAMP < as.POSIXct("2018-02-14 23:00:00"))

dat3.1 <- importCSdata('Steph 2/Steph_2_Hourly1_2018-07-30T11-23.dat') 

dat3.2 <- importCSdata('Steph 2/Steph_2_Hourly2_2018-07-30T11-31.dat')

dat3 <- dat3.1 %>% 
  inner_join(dat3.2, by = 'TIMESTAMP') %>% 
  # Filter to prevent overlap
  filter(TIMESTAMP < as.POSIXct("2018-08-09 01:00:00"))

dat4.1 <- importCSdata('Steph 2/Steph 2_Hourly1_10-18-2018.dat') 

dat4.2 <- importCSdata('Steph 2/Steph 2_Hourly2_10-18-2018.dat')

dat4 <- dat4.1 %>% 
  inner_join(dat4.2, by = 'TIMESTAMP') %>% 
  # Filter to prevent overlap
  filter(TIMESTAMP > as.POSIXct("2018-07-13 07:00:00"))


dat5.1 <- importCSdata('Steph 2/Steph 2 Hourly1_2019-01-21.dat') 

dat5.2 <- importCSdata('Steph 2/Steph 2 Hourly2_2019-01-21.dat')

dat5 <- dat5.1 %>% 
  inner_join(dat5.2, by = 'TIMESTAMP')%>% 
  # Filter to prevent overlap
  filter(TIMESTAMP > as.POSIXct("2018-10-18 12:00:00"))

dat <- rbind(dat1, dat2, dat3, dat4, dat5) %>% 
  filter(TIMESTAMP >= as.POSIXct("2017-12-01 00:00:00")) %>% 
  filter(TIMESTAMP <= as.POSIXct("2019-01-01 00:00:00"))

write.csv(dat, 'Stephanie2_20171201_20190101.csv')
