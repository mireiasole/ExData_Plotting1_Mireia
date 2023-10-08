#Load dataset
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Set language of dates in English
Sys.setlocale("LC_TIME", "English")

#Transform Date & Time column to date class and select values for wanted dates
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power_d <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02", ]
time <- as.POSIXct(paste(power_d$Date, power_d$Time))
power_d$Time <- strptime(power_d$Time, format="%H:%M:%S")


#Convert the needed columns to numeric values
power_d$Sub_metering_1 <- as.numeric(power_d$Sub_metering_1)
power_d$Sub_metering_2 <- as.numeric(power_d$Sub_metering_2)
power_d$Global_active_power <- as.numeric(power_d$Global_active_power)
power_d$Global_reactive_power <- as.numeric(power_d$Global_reactive_power)
power_d$Voltage <- as.numeric(power_d$Voltage)

#Create a setting of 2 by 2 to put the four plots 
par(mfrow = c(2,2))

#Create line plot of time against Global active power
plot(time, power_d$Global_active_power, type="l", 
     xlab = "", ylab="Global Active Power")

#Create line plot of time against Voltage
plot(time, power_d$Voltage, type="l", 
     xlab = "datetime", ylab="Voltage")


#Create line plot of time against the energy sub metering values in different colors
plot(time, power_d$Sub_metering_1, type="l", col="black",
     xlab = "", ylab="Energy sub metering",)
lines(time, power_d$Sub_metering_2, type="l", col="red")
lines(time, power_d$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, cex=0.75, box.lwd = 0, bty = "n")


#Create line plot of time vs global reactive power
plot(time, power_d$Global_reactive_power, type="l", 
     xlab = "datetime", ylab="Global_reactive_power")

#Create a copy of the graph in a png file
dev.copy(png, file = "plot4.png")
dev.off()
