power_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

subset_power <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]

png("plot1.png", width=480, height=480)
plot1 <- as.numeric(subset_power$Global_active_power)
hist(plot1, main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off() 