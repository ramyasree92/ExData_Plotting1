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

##Creating a layout for 4 graphs in 2 rows and 2 columns
par(mfrow = c(2, 2))

#Plotting datetime against Global Active Power data
plot(powerdata$datetime, as.numeric(as.character(powerdata$Global_active_power)), type = "n", xlab = "", ylab = "Global Active Power (Kilowatts)")
lines(powerdata$datetime, as.numeric(as.character(powerdata$Global_active_power))) 

#Plotting datetime against Voltage data
plot(powerdata$datetime, as.numeric(as.character(powerdata$Voltage)), type = "n", xlab = "datetime", ylab = "Voltage")
lines(powerdata$datetime, as.numeric(as.character(powerdata$Voltage)))

#Plotting datetime against Sub_metering_1, Sub_metering_2, Sub_metering_3
plot(powerdata$datetime, powerdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n", ylim = c(0, 30))
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_1)))
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_2)), col = "red")
lines(powerdata$datetime, as.numeric(as.character(powerdata$Sub_metering_3)), col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, cex = 0.6, box.lwd = 0)

##Plotting datetime against Global reactive Power data
plot(powerdata$datetime, as.numeric(as.character(powerdata$Global_reactive_power)), xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(powerdata$datetime, as.numeric(as.character(powerdata$Global_reactive_power)))

##Copying data from screen to png file
dev.copy(png, filename = "plot4.png", width = 480, height = 480, units = "px")
dev.off()
