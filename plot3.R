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
## Generating Plot 3
png("plot3.png",width = 480, height = 480)
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(finalelectricalData$SetTime, finalelectricalData$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
#plot(finalelectricalData$SetTime, finalelectricalData$Sub_metering_2,type="l" ,col=columnlines[2])
lines(finalelectricalData$SetTime, finalelectricalData$Sub_metering_2, col=columnlines[2])
lines(finalelectricalData$SetTime, finalelectricalData$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")
dev.off()