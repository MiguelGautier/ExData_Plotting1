## Script that examine how household energy usage varies over a 2-day period in February, 2007.

## Download Project Files
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir.create("HouseholdConsumption")
destination <- file.path(getwd(),"HouseholdConsumption")
if(!file.exists(file.path(destination,"Household_Power_Consumption.zip"))){
  download.file(dataUrl, destfile = file.path(destination,"Household_Power_Consumption.zip"))
}

unzip(file.path(destination,"Household_Power_Consumption.zip"), exdir = destination)

#Install and load libraries
if(!("data.table" %in% installed.packages())) install.packages("data.table")
library("data.table")
if(!("lubridate" %in% installed.packages())) install.packages("lubridate")
library("lubridate")

#Load data
Data <- fread(file.path(destination,"household_power_consumption.txt"), na.string = "?")

#SubSet data and format Date as date
Subdata <- subset(Data, Date %in% c("1/2/2007","2/2/2007"))
Subdata$Date = as.Date(Subdata$Date,format("%d/%m/%Y"))

#Create Datetime column
Subdata$Datetime = ymd_hms(paste(Subdata$Date,Subdata$Time))

# Create plot into png
setwd(file.path(getwd(),"ExData_Plotting1"))
png("Plot2.png",width= 480, height = 480)
with(Subdata,plot(Global_active_power~Datetime,type="l",
                  xlab="",
                  ylab = "Global active power (kilowatts)"))
dev.off()