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


#Load data
Data <- fread(file.path(destination,"household_power_consumption.txt"), na.string = "?")

#SubSet data and format Date as date
Subdata <- subset(Data, Date %in% c("1/2/2007","2/2/2007"))
Subdata$Date = as.Date(Subdata$Date,format("%d/%m/%Y"))


# Create plot into png
setwd(file.path(getwd(),"ExData_Plotting1"))
png("Plot1.png",width= 480, height = 480)
hist(Subdata$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "Red"
     )
dev.off()