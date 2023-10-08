#Load dataset
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Set language of dates in English
Sys.setlocale("LC_TIME", "English")

#Transform Date & Time column to date class and select values for wanted dates
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power_d <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02", ]
time <- as.POSIXct(paste(power_d$Date, power_d$Time))
power_d$Time <- strptime(power_d$Time, format="%H:%M:%S")


#Convert the needed column to numeric values
power_d$Global_active_power <- as.numeric(power_d$Global_active_power)

#Create line plot of time against Global active power
plot(time, power_d$Global_active_power, type="l", 
     xlab = "", ylab="Global Active Power (kilowatts)")


#Create a copy of the graph in a png file
dev.copy(png, file = "plot2.png")
dev.off()
