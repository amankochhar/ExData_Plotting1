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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
#generate plot
hist(selectedData$Global_active_power,col="red",ann=FALSE)
title("Global Active Power", xlab="Global Active Power (kilowatts)",ylab="Frequency")
#turn off png device
dev.off()