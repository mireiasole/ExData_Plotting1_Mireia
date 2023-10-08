#Load dataset
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Transform Date column to date class and select values for wanted dates
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power_d <- power[power$Date == "2007-02-01" | power$Date == "2007-02-02", ]

#Convert the needed column to numeric values
power_d$Global_active_power <- as.numeric(power_d$Global_active_power)

#Create histogram
hist(power_d$Global_active_power, breaks=12, col = "red",
     xlab="Global Active Power (kilowatts)", main =substitute(paste(bold('Global Active Power'))))


#Create a copy of the graph in a png file
dev.copy(png, file = "plot1.png")
dev.off()
