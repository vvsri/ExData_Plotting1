#download file and save in working directory
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "household_power_consumption.zip"
householdFile <- "household_power_consumption.txt"
##
if (!file.exists(householdFile)) {
        download.file(downloadURL, downloadFile)
        unzip(downloadFile, overwrite = T)
}
#Read Data
electrical<-read.table("household_power_consumption.txt",header=T, sep=";", na.strings="?")
head(electrical)
#Filter data with given dates
finalelectricalData <- electrical[electrical$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(finalelectricalData$Date, finalelectricalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalelectricalData <- cbind(SetTime, finalelectricalData)
## Generating Plot 4
png("plot4.png",width = 480, height = 480)
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(finalelectricalData$SetTime, finalelectricalData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(finalelectricalData$SetTime, finalelectricalData$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(finalelectricalData$SetTime, finalelectricalData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(finalelectricalData$SetTime, finalelectricalData$Sub_metering_2, type="l", col="red")
lines(finalelectricalData$SetTime, finalelectricalData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(finalelectricalData$SetTime, finalelectricalData$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
dev.off()
