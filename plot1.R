library(downloader)
library(data.table)
##
## Start of Script plot1.r
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
##
##  Plot1
##
hist(dataSelection$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
##
## Creat png file
##
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
##
## End of Script plot1.r
##