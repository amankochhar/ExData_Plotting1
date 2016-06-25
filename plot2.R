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
#open png device to draw the plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
#generate plot
plot(selectedData$Global_active_power,type='l',xaxt="n",ann=FALSE)
#add weekdays as the x-axis label
axis(1,at=seq(1,2880,1439),lab=weekdays(seq(startDate,endDate,by='1 day'),1))
#set the title and y axis label
title("Plot 2", ylab="Global Active Power (kilowatts)")
#turn off the png device
dev.off()
