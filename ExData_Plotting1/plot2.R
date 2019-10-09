power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

subset_power <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

dateTime <- paste(subset_power$Date, subset_power$Time)
dateTime <- setNames(dateTime, "DateTime")

subset_power <- cbind(dateTime, subset_power)
subset_power$dateTime <- as.POSIXct(dateTime)

png("plot2.png", width=480, height=480)
plot(subset_power$Global_active_power~subset_power$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()