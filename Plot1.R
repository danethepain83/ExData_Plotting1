##Reading in the file
file_in <- file("household_power_consumption.txt")
ba <- read.table(text = grep("^[1,2]/2/2007", readLines(file_in), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

##Creating Plot 1
hist(ba$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

## Getting full dataset
full_dataset <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      na.strings = "?", nrows = 2075259, check.names = F, 
                      stringsAsFactors = F, comment.char = "", quote = '\"')
full_dataset$Date <- as.Date(full_dataset$Date, format = "%d/%m/%Y")

## Subset of the data
data <- subset(full_dataset, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(full_dataset)

## Converting the dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

dev.copy(png, filename = "plot1.png", width=480, height=480)
dev.off()