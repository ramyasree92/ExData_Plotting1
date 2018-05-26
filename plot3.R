library(lubridate) #For 

##Reading data and subsetting for date values of 1/2/2007 2/2/2007

power <- read.csv("household_power_consumption.txt", sep = ";")
powerdata <- subset(power, as.character(power$Date) == "2/2/2007")
powerdata <- rbind(subset(power, as.character(power$Date) == "1/2/2007"), powerdata)
rownames(powerdata) <- NULL
rm(power)

##Combining Date and Time values into one column
powerdata$datetime <- paste(powerdata$Date, powerdata$Time)

##Converting datetime variable to class POSIXt POSIXct
powerdata$datetime <- dmy_hms(powerdata$datetime)

#Creates a blank plot with appropriate x and y axes ables and scale
plot(powerdata$datetime, powerdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n", ylim = c(0, 30))

##Adding graph for each of Submetering Data
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_1)))
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_2)), col = "red")
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_3)), col = "blue")

##Adding legend to describe the data
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

##Copying data from screen to png file
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
