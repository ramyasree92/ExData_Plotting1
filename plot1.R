##Reading data and subsetting for date values of 1/2/2007 2/2/2007

power <- read.csv("household_power_consumption.txt", sep = ";")
powerdata <- subset(power, as.character(power$Date) == "2/2/2007")
powerdata <- rbind(subset(power, as.character(power$Date) == "1/2/2007"), powerdata)
rownames(powerdata) <- NULL
rm(power)

##Drawing histogram for Global Active Power frequency in Kilowatt
hist(as.numeric(as.character(powerdata$Global_active_power))/1000, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

##Copying data from screen to png file
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px")
dev.off()