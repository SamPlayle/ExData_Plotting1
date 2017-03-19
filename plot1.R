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

## Open a PNG graphics device
png(filename = "plot1.png")

## Create our histogram (480*480 is default size)
with(feb12, 
     hist(as.numeric(Global_active_power), 
          xlab = "Global Active Power (kilowatts)", 
          main = "Global Active Power", 
          col = "red"
          )
     )

## Close graphics device
dev.off()