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
png("Plot 3.png", width = 480, height = 480, units = "px")

#Making the plot itself
plot(household_energy$DateTime, as.character(household_energy$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(household_energy$DateTime, as.numeric(as.character(household_energy$Sub_metering_2)), col="red")
lines(household_energy$DateTime, as.numeric(as.character(household_energy$Sub_metering_3)), col="blue")
legend("topright", lty = 1, col=c("black","red","blue"), c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3"))

#Turning off device
dev.off()

