##creating class to store the Date format given in the file
par(mfrow = c(2,2))
setClass('myDate')
##function to replicate the date format in the file to use as colClass
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
##reading the whole data with proper colCLasses
wholeData<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.string="?",colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
##converting the second column to proper time format
##wholeData[,2]<-as.POSIXct(wholeData[,2],format="%T")
##filtering out data points only two dates 
filteredData<-subset(wholeData,Date %in% as.Date(c("2007-02-01","2007-02-02")))
##plot the histogram with global_active_power
weekdaysTimeStamp<-c(as.numeric(as.POSIXct("2007-02-01")),as.numeric(as.POSIXct("2007-02-02")),as.numeric(as.POSIXct("2007-02-03")))
filteredData$dateTime<-strftime(paste(filteredData$Date,filteredData$Time))
##graph 1
with(filteredData,plot(as.numeric(as.POSIXct(dateTime)),Global_active_power,type="l",xaxt='n',ylab="Global Active Power",xlab=""))
axis(1,at=weekdaysTimeStamp,labels=c("Thu","Fri","Sat"))

##graph 2
with(filteredData,plot(as.numeric(as.POSIXct(dateTime)),Voltage,type="l",xaxt='n',ylab="Global Active Power",xlab="datetime"))
axis(1,at=weekdaysTimeStamp,labels=c("Thu","Fri","Sat"))

##graph 3
with(filteredData,plot(as.numeric(as.POSIXct(dateTime)),Sub_metering_1,type="l",xaxt='n',ylab="Energy Submetering",xlab=""))
lines(as.numeric(as.POSIXct(filteredData$dateTime)),filteredData$Sub_metering_2,col="red")
lines(as.numeric(as.POSIXct(filteredData$dateTime)),filteredData$Sub_metering_3,col="blue")
legend("topright",lwd=c(2.5,2.5),col = c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis(1,at=weekdaysTimeStamp,labels=c("Thu","Fri","Sat"))

##graqph 4
with(filteredData,plot(as.numeric(as.POSIXct(dateTime)),Global_reactive_power,type="l",xaxt='n',ylab="Global Active Power",xlab="datetime"))
axis(1,at=weekdaysTimeStamp,labels=c("Thu","Fri","Sat"))



dev.copy(png,"plot4.png")
dev.off()
