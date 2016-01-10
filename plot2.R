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
## Generating Plot 2

png("plot2.png",width = 480, height = 480)
finalelectricalData$SetTime
#plot(finalelectricalData$SetTime, finalelectricalData$Global_active_power,type="l")
plot(finalelectricalData$SetTime, finalelectricalData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()