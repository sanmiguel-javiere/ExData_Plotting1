## This is a scrip to generate a series of exploratory plots using basic R graphing capabilities
## The data file is saved in the working directory
## Data file is name: household_power_consumption.txt
## Varaibles (columns) are separated by ";"

## first step is to read the dataset and create a new dataframe
power_comp <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

## Verify names of variables and characteristics of data frame by using head, str, summary functions
str(power_comp)
head(power_comp, n=3)
summary(power_comp)
dim(power_comp)
names(power_comp)

## Activate pacakges
library(dplyr)
library(lubridate)

## Subset the datafram, so that we have only data for February 1st and 2nd, 2007
subset_power_comp <- filter(power_comp, Date =="1/2/2007" | Date =="2/2/2007")

## Convert date and time to Date and Time Classes
subset_power_comp$Date <- as.Date(subset_power_comp$Date, format = "%d/%m/%Y")


## Combine date and time to create a new variable names Datetime
Datetime <- paste(as.Date(subset_power_comp$Date), subset_power_comp$Time)
subset_power_comp$Datetime <- as.POSIXct(Datetime)

## Create Plot 2 - Line plot of Global Active Power on function of time of the day
with(subset_power_comp, plot(Global_active_power~Datetime, type="l", xlab="", 
                             ylab = "Global Active Power (kilowatts)"))

## Create a png file with plot 2
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
