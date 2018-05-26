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
plot(powerdata$datetime, as.numeric(as.character(powerdata$Global_active_power)), type = "n", xlab = "", ylab = "Global Active Power (Kilowatts)")

# Adds lines to the plot from x, y values passed
lines(powerdata$datetime, as.numeric(as.character(powerdata$Global_active_power))) 


dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px")
dev.off()