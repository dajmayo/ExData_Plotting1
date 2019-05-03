#Load library dplyr
library(dplyr)

#Reading the text file
household_energy <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Format date to Date Type
household_energy$Date <- as.Date(household_energy$Date, "%d/%m/%Y") %>% format("%Y-%m-%d")

#Filtering dates (Reading only from these dates) using as.Date()
household_energy <- subset(household_energy, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
household_energy[is.na(household_energy)] <- "?"

#View text file in preparation for plotting
View(household_energy)

#Combing Date and Time
household_energy$DateTime <- strptime(paste(household_energy$Date, household_energy$Time), "%Y-%m-%d %H:%M:%S")

#Fixing width and height and making PNG screen device
png("Plot 4.png", width = 480, height = 480, units = "px")

#For the rows
par(mfrow=c(2,2))

#Making the plot itself
#Plot 1
plot(household_energy$DateTime, as.numeric(as.character(household_energy$Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Plot 2
plot(household_energy$DateTime, as.character(household_energy$Voltage), type="l", xlab="datetime", ylab="Voltage")

#plot 3
plot(household_energy$DateTime, as.character(household_energy$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(household_energy$DateTime, as.numeric(as.character(household_energy$Sub_metering_2)), col="red")
lines(household_energy$DateTime, as.numeric(as.character(household_energy$Sub_metering_3)), col="blue")
legend("topright", lty = 1, bty = "n", col=c("black","red","blue"), c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3"))

#Plot 4
plot(household_energy$DateTime, as.numeric(as.character(household_energy$Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")

#Turning off device
dev.off()

