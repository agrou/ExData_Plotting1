# Household Power Consumption Data  

# Code to produce plot 1

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

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels

# Plot 1
png("plot1.png", width = 480, height = 480)
par(mar = c(5, 4, 4, 2))
with(dataSub, hist(GAP, col = "red", main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"), ylim = 1200)
dev.off()
