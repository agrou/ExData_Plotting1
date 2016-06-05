# Household Power Consumption Data  

# Code to produce plot 4

# Load the data 
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./Household_data")){dir.create("./Household_data")}
download.file(file, "./Household_data", method = "curl")
if(!file.exists("household_power_consumption.txt")){unzip("./Household_data", "household_power_consumption.txt")}

#Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", stringsAsFactors = FALSE, dec = ".")

# Subset the data for the 2-day period in February, 2007
dataSub <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Convert Date and Time variables into date and times classes
dates <- strptime(paste(dataSub$Date, dataSub$Time), "%d/%m/%Y %H:%M:%S")

# Clean up the data
names(dataSub)
GAP <- as.numeric(dataSub$Global_active_power)
SM_1 <- as.numeric(dataSub$Sub_metering_1)
SM_2 <- as.numeric(dataSub$Sub_metering_2)
SM_3 <- as.numeric(dataSub$Sub_metering_3)
Voltage <- as.numeric(dataSub$Voltage)
GRP <-  as.numeric(dataSub$Global_reactive_power)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels

# Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(5, 5, 4, 2))
plot(dates, GAP, type = "l", xlab = "", ylab = "Global Active Power")
plot(dates, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(dates, SM_1, type = "l", ylab = "Energy Submetering", xlab ="")
lines(dates, SM_2, type = "l", col = "red")
lines(dates, SM_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, lwd = 2, box.lwd = 1, box.lty = 0)
plot(dates, GRP, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()