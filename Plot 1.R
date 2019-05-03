#Load library dplyr
library(dplyr)

#Reading the text file
household_energy <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Format date to Date Type
household_energy$Date <- as.Date(household_energy$Date, "%d/%m/%Y")

#Filtering dates (Reading only from these dates) using as.Date()
household_energy <- subset(household_energy, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Combine Date and Time columns to DateTime
household_energy$DateTime <- paste(household_energy$Date, household_energy$Time)

#Selecting DateTime column as first column then the rest
household_energy <- household_energy[, c(10,3:9)]

#View text file in preparation for plotting
View(household_energy)

#Fixing width and height and making PNG screen device
png("Plot 1.png", width = 480, height = 480, units = "px")

#Making the histogram itself
hist(as.numeric(household_energy$Global_active_power), xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

#Turning off device
dev.off()

