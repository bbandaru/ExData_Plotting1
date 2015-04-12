## This is Course Project-1 Work for 
## Explortary Data Analysis course 
## 
## Created by Bhaksar Bandaru
##
## Date: 12th April 2015
##
## ----------------------------------------------------------
##
## step 1 - create the code for the downloading the file and 
## unzip the file into the current working directory
##
## Assume that the required packages are already loaded
##
## 
## -----------------------------------------------------------
##
require (lubridate)


## assumption that the code is run on the windows OS computer and 
## internet2 value is set for the https usage

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- basename(url)


## code has been tested with the Windows OS, if this need to be verified on MAC system
## then replace the following instructuin with proper method using curl for MAC computer
setInternet2(TRUE)
if (!file.exists(file))
{download.file (url, file, method= "auto", quiet = TRUE)}
## download.file (url, file, method= "auto", quiet = TRUE)

##now unzip the file to the current working directory
unzip(file, exdir = ".",  overwrite=TRUE)

## the unzip should create the following directory structure in the working directory
## 
##                                        
## 
## list.files () under this default directory sructure should give access to the
## unxzip file
##[1] "exdata%2Fdata%2Fhousehold_power_consumption.zip"
##[2] "household_power_consumption.txt"  
##[3] "Plot3.R"
##


inputFile <- list.files()[2]
##
inputData <- read.csv ( inputFile, sep=";", na.strings = c("NA", "", " ", "?"))


df <- rbind (inputData[inputData$Date == "1/2/2007",],inputData[inputData$Date == "2/2/2007",] )
dateTime <- dmy_hms(paste(df$Date, df$Time, sep = " "))
df <- cbind (df, dateTime)

par (mar=c(4,4,2,2))
plot.ts( df$Sub_metering_1, ylim = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)), type = "l", xlab = "", ylab = "", xaxt = "n")
par(new = TRUE)
plot.ts(df$Sub_metering_2, ylim = range(c(df$Sub_meterting_1, df$Sub_metering_2, df$Sub_metering_3)),type = "l", col = "red",xlab = "", ylab = "", xaxt = "n", yaxt = "n")
par(new = TRUE)
plot( df$dateTime,df$Sub_metering_3, ylim = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)), type = "l", col= "blue", ylab = "Energy sub metering", xlab = "", yaxt = "n")
legend ("topright", legend = c("Sub_metering_1 ", "Sub_metering_2 ","Sub_metering_3 "), lty = 1, col = c("black", "red", "blue")) 
dev.copy (png, file = "plot3.png", width = 480 , height = 480)
dev.off()
