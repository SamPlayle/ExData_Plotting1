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
feb12$POSIXct <- as.POSIXct(paste(feb12$Date,feb12$Time), "%d/%m/%Y %H:%M:%S", tz = "CET")

## Open a PNG graphics device
png(filename = "plot3.png")

## Create a "blank" plot with type = "n" (480*480 is default size)
with(feb12,
     plot(POSIXct, as.numeric(Sub_metering_1),
          xlab = "",
          ylab = "Energy sub metering", 
          main = "", 
          type = "n"))

## Add lines
with(feb12, 
     lines(POSIXct, as.numeric(Sub_metering_1)
     )
)
with(feb12, 
     lines(POSIXct, as.numeric(Sub_metering_2), 
           col = "red"
     )
)
with(feb12, 
     lines(POSIXct, as.numeric(Sub_metering_3), 
           col = "blue"
     )
)

## Add legend

legend("topright", 
       lty = c(1,1,1), 
       col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
       )

## Close graphics device
dev.off()