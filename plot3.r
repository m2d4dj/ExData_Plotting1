## Reading the data in from the course website. 

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "household_power_consumption.zip", method='curl')
data<-read.table(unz('household_power_consumption.zip', 'household_power_consumption.txt'), 
                 sep=";", header=TRUE, na.strings='?', colClasses=c('character', 'character', rep('numeric',7)))

## Add a new column with the date and time and format as POSIXlt.

data$DateTime<-paste(data$Date, data$Time)
data$DateTime<-strptime(data$DateTime, '%d/%m/%Y %H:%M:%S')

## Keep only the data from February 1-2, 2007.

keep1<-format(data$DateTime, '%Y')=='2007' & format(data$DateTime, '%m')=='02'
data<-data[keep1,]
keep2<-format(data$DateTime, '%d')=='01' | format(data$DateTime, '%d')=='02'
data<-data[keep2,]

## Create the plot and save to png file.  

png(file='plot3.png', width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, type='n', xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
  lty=c(1,1,1), lwd=c(2.5,2.5, 2.5), col=c("black","red", "blue") )
dev.off()