power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

subset_power <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

dateTime <- paste(subset_power$Date, subset_power$Time)
dateTime <- setNames(dateTime, "DateTime")

subset_power <- cbind(dateTime, subset_power)
subset_power$dateTime <- as.POSIXct(dateTime)

png("plot3.png", width=480, height=480)
with(subset_power, {plot(Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~dateTime, col='Red')
lines(Sub_metering_3~dateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()