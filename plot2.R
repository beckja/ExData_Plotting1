#! /usr/bin/env Rscript

# file: plot2.R
#
# Purpose: This script reads in data from a file containing
# household power consumption data.  It then filters to a
# desired date range and generates a plot of "Global
# Active Power" vs time, which is saved to a .png file.

library(dplyr)
data = read.table("household_power_consumption.txt", 
                  sep=";", 
                  header=TRUE, 
                  na.strings=c("?"),
                  stringsAsFactors = FALSE)
hpc <- tbl_df(data)
hpc <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
hpc <- mutate(hpc, DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
png(filename="plot2.png", width=480, height=480, units="px")
with(hpc, plot(DateTime, Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
