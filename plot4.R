## downloading the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "household_power_consumption.zip", method = "curl")

## unzipping the file 
unzip("household_power_consumption.zip", overwrite = TRUE)

## reading in the data
txtFile <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", colClasses=c(NA,NA,"NULL","NULL","NULL","NULL","NULL","NULL","NULL"))

#concatenate data and time as character
eDate<-paste(txtFile$Date,txtFile$Time)
#create datetime class by using strptime function and the as.Date() function
eDate<-as.Date(strptime(paste(txtFile$Date,txtFile$Time),"%d/%m/%Y %H:%M:%S"))
#set start date
startDate<-as.Date("2007-02-01")
#set end date
endDate<-as.Date("2007-02-03")
#find data between the start date and the end date 
c<-(eDate>=startDate & eDate<endDate)
#read the rest of the dataset
d<-read.csv('household_power_consumption.txt',sep=';',header=TRUE,colClasses=c("NULL","NULL",NA,NA,NA,NA,NA,NA,NA),na.string="?")
#use subsetting to retrieve data only for dates we are looking for
selectedData<-data.frame(eDate[c==TRUE],d[c==TRUE,])
#set the colours of the lines for sub plot 3
plot_colors=c('black','red','blue')
#open png device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
#ceate 4 sub plots
par(mfrow=c(2,2))
#generate 1st subplot
plot(selectedData$Global_active_power,type='l',xaxt="n",ann=TRUE, ylab="Global Active Power", xlab="")
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1))
#set the limits for the y axis
ylimits<-c(min(selectedData$Voltage),max(selectedData$Voltage))
#plot 2nd subplot
plot(selectedData$Voltage,type='l',xaxt="n",ann=TRUE, ylim=ylimits, ylab="Voltage", xlab="datetime")
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1))
#generate 3rd sub plot
plot(selectedData$Sub_metering_1,type='l',xaxt="n",ann=TRUE, ylab="Energy sub meeting" , xlab="")
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1),ylab="Energy sub meeting")
lines(selectedData$Sub_metering_2,type='l',col=plot_colors[2])
lines(selectedData$Sub_metering_3,type='l',col=plot_colors[3])
legend("topright",names(selectedData[,6:8]),col=plot_colors,horiz=FALSE,lty=c(1,1))
#generate 4th subplot
plot(selectedData$Global_reactive_power,type='l',xaxt="n",ann=TRUE, ylab="Global_reactive_power", xlab="datetime")
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1))
#turn off png device
dev.off()