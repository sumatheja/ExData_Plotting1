##creating class to store the Date format given in the file
setClass('myDate')
##function to replicate the date format in the file to use as colClass
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
##reading the whole data with proper colCLasses
wholeData<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.string="?",colClasses=c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
##converting the second column to proper time format
wholeData[,2]<-as.POSIXct(wholeData[,2],format="%T")
##filtering out data points only two dates 
filteredData<-subset(wholeData,Date %in% as.Date(c("2007-02-01","2007-02-02")))
##plot the histogram with global_active_power
hist(filteredData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
##save it to plot1.png
dev.copy(png,"plot1.png")
dev.off()
