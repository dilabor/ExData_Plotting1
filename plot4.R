library(downloader)
library(data.table)
##
## Start of Script plot4.r
##
##
## Download zipped dataset
##
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(url, dest="dataset.zip", mode="wb")
##
## Date datset downloaded
##
dateDownloaded <- date()
##
## Unzip downloaed file
##
unzip("dataset.zip", exdir = "./dataset")
##
## Read and subset dataset
##
data <- read.table("./dataset/household_power_consumption.txt", header=T, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dataSelection <- data[data$Date=="2007-02-01" | data$Date =="2007-02-02",]
##
## data conversion
##
dataSelection$Global_active_power <- as.numeric(as.character(dataSelection$Global_active_power))
dataSelection <- transform(dataSelection,dayofweek =as.POSIXct(paste(Date,Time)), "%d,%m,%Y %H:%M:%S")
dataSelection$Sub_metering_1 <- as.numeric(as.character(dataSelection$Sub_metering_1))
dataSelection$Sub_metering_2 <- as.numeric(as.character(dataSelection$Sub_metering_2))
dataSelection$Sub_metering_3 <- as.numeric(as.charatcer(dataSelection$Sub_metering_3))
dataSelection$Voltage <- as.numeric(as.character(dataSelection$Voltage))
dataSelection$Global_reactive_power <- as.numeric(as.character(dataSelection$Global_reactive_power))
##
##  Plot4 and write png file
##
png(filename = "plot4.png", width=480, height=480)
par(mfrow = c(2,2))
##
## Sub-plot 1
##
with(dataSelection, plot(dayofweek, Global_active_power, ylab="Global Active Power", xlab="", type="l"))
##
## Sub-plot 2
##
with(dataSelection, plot(dayofweek, Voltage, type="l", xlab = "datetime", ylab = "Voltage"))
##
## Sub-plot 3
##
with(dataSelection, plot(dayofweek, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l"))
lines(dataSelection$dayofweek, dataSelection$Sub_metering_2, col=2) 
lines(dataSelection$dayofweek, dataSelection$Sub_metering_3, col=4)
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col = c(1,2,4), bty="n")
##
## Sub-plot 4
##
with (dataSelection, plot(dayofweek, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
##
dev.off()
##
## End of Script plot4.r
##