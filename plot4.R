#! /usr/bin/env Rscript

# file: plot4.R
#
# Purpose: This script reads in data from a file containing
# household power consumption data.  It then filters to a
# desired date range and generates a 2x2 matrix of four 
# subplots:
#   - Global Active Power vs time
#   - Voltage vs time
#   - Sub-metering vs time
#   - Global Reactive Power vs time
# which is saved to a .png file.

library(dplyr)
data = read.table("household_power_consumption.txt", 
                  sep=";", 
                  header=TRUE, 
                  na.strings=c("?"),
                  stringsAsFactors = FALSE)
hpc <- tbl_df(data)
hpc <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
hpc <- mutate(hpc, DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with(hpc, plot(DateTime, Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)"))
with(hpc, plot(DateTime, Voltage, type="l", xlab="datetime"))
with(hpc, plot(DateTime, Sub_metering_1, type="l", col="black",
               xlab="", ylab="Energy sub metering"))
with(hpc, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(hpc, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
with(hpc, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))
dev.off()
