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
#set the colours for the different data series
plot_colors=c('black','red','blue')
#open a png device 
png(filename = "plot3.png", width = 480, height = 480, units="px")
#plot the first data series - Sub_metering_1
plot(selectedData$Sub_metering_1,type='l',xaxt="n",ann=FALSE)
#set the x axis as days of the week uning the start and end dates
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1))
#set the title and lable for the y axis
title("Plot 3", ylab="Energy sub meeting")
# add the 2nd data series - Sub_metering_2 and set the colour of the line
lines(selectedData$Sub_metering_2,type='l',col=plot_colors[2])
# add the 3rd data series - Sub_metering_3 and set the colour of the line
lines(selectedData$Sub_metering_3,type='l',col=plot_colors[3])
#add the legend to the top right corner
legend("topright",names(selectedData[,6:8]),col=plot_colors,horiz=FALSE,lty=c(1,1))
# turn off the png device
dev.off()