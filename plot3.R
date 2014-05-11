setInternet2(use = TRUE)

# download the data file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
download.file(fileurl, destfile=zipfile, method="auto")

# unzip the data file
unzipfile <- unzip(zipfile)

library(data.table)

# read the data file. use data.table for faster reading.
DT <- fread(unzipfile, na.strings="?", colClasses="character")

# cut the data
DTcut <- DT[DT$Date %in% c("1/2/2007","2/2/2007")]

# convert the data from character to numeric. use data.frame for easier conversion.
DF <- data.frame(DTcut)
for(i in 3:9)
  DF[,i] <- as.numeric(DF[,i])

# convert Date and Time to one variable datetime
datetime <- strptime(paste(DF$Date, DF$Time), "%d/%m/%Y %H:%M:%S")

# Plot 3
png(file="plot3.png")
plot(datetime, DF[,7], type="l", xlab="", ylab="Energy sub metering")
lines(datetime, DF[,8], col="red", type="l", xlab="", ylab="Energy sub metering")
lines(datetime, DF[,9], col="blue", type="l", xlab="", ylab="Energy sub metering")
legend(x="topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()
