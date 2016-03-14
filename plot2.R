# Download and extract file
#install.packages("RCurl")
library(RCurl)
url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
destFile <- "household_power_consumption.zip"
download.file(url, destFile)
dataFileFrame <- unzip(destFile,  list = TRUE) #household_power_consumption.txt
dataFileName <- dataFileFrame[1, "Name"]
unzip(destFile, dataFileName)

# Read .txt
#install.packages("data.table")
library(data.table)
dataFileName <- "household_power_consumption.txt"
DT <- fread(dataFileName, ";", na.strings = "?", header = TRUE)
DT$Date <- as.Date(DT$ Date, "%d/%m/%Y")
DT$Global_active_power <- as.numeric(DT$Global_active_power)

# Subset data by date
dateRange <- as.Date(c("2007-02-01", "2007-02-02"))
DT <- DT[DT$ Date >= dateRange[1] & Date <= dateRange[2]]
width <- 480
height <- 480

# Plot 2
dateTime <- strptime(paste(DT$Date, DT$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
png("plot2.png", width, height)
plot(dateTime, DT$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
dev.off()