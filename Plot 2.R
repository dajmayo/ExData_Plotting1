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

#Fixing width and height and making PNG screen device
png("Plot 2.png", width = 480, height = 480, units = "px")

#Formatting combined Date and Time
household_energy$Datetime <- paste(household_energy$Date,household_energy$Time,sep = " ") %>% strptime(format = "%Y-%m-%d %H:%M:%S")

#Making the plot itself
plot(household_energy$Datetime, as.numeric(as.character(household_energy$Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Turning off device
dev.off()

