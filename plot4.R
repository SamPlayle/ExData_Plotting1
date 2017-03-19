## The URL to download the data
DataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
## Create a temporary file to download the data
temp <- tempfile()
download.file(DataURL,temp)
## Unzip the data and read it into R. NB the separator is 
## semicolon ";". The file with the data is called 
## "household_power_consumption.txt".
project1data <- read.csv(unz(temp,"household_power_consumption.txt"), 
                           header = TRUE,
                           sep = ";", 
                           stringsAsFactors = FALSE
                         )
unlink(temp)

## Subset the data to the two days we want
feb12 <- project1data[project1data$Date == "1/2/2007" | project1data$Date == "2/2/2007",]

## Add a new column with time and date in machine-readable format
feb12$datetime <- as.POSIXct(paste(feb12$Date,feb12$Time), "%d/%m/%Y %H:%M:%S", tz = "CET")

## Coerce fields into numerics
feb12$Voltage <- as.numeric(feb12$Voltage)
feb12$Global_reactive_power <- as.numeric(feb12$Global_reactive_power)
feb12$Global_active_power <- as.numeric(feb12$Global_active_power)
feb12$Sub_metering_1 <- as.numeric(feb12$Sub_metering_1)
feb12$Sub_metering_2 <- as.numeric(feb12$Sub_metering_2)
feb12$Sub_metering_3 <- as.numeric(feb12$Sub_metering_3)

## Open a PNG graphics device
png(filename = "plot4.png")

## Create 2*2 grid of plots

par(mfrow = c(2,2))
with(feb12,
         {
         
## Top left plot
           
           plot(datetime, Global_active_power,
                xlab = "",
                ylab = "Global active power", 
                main = "", 
                type = "n")
           lines(datetime, Global_active_power)
        
## Top right plot
           
           plot(datetime, Voltage, type = "n")
           lines(datetime, Voltage)
           
## Bottom left plot
           
           plot(datetime, Sub_metering_1,
                xlab = "",
                ylab = "Energy sub metering", 
                main = "", 
                type = "n")
           lines(datetime, Sub_metering_1)
           lines(datetime, Sub_metering_2, 
                 col = "red"
           )
           lines(datetime, Sub_metering_3, 
                 col = "blue"
           )
           legend("topright", 
                  lty = c(1,1,1), 
                  col = c("black","blue", "red"), 
                  legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
                  bty = "n" ##No box around
           )
## Bottom right plot
           
           plot(datetime, Global_reactive_power, type = "n")
           lines(datetime, Global_reactive_power)
    }
)   

## Close graphics device
dev.off()