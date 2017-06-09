#! /usr/bin/env Rscript

# file: plot1.R
#
# Purpose: This script reads in data from a file containing
# household power consumption data.  It then filters to a
# desired date range and generates a histogram of "Global
# Active Power", which is saved to a .png file.

library(dplyr)
data = read.table("household_power_consumption.txt", 
                  sep=";", 
                  header=TRUE, 
                  na.strings=c("?"),
                  stringsAsFactors = FALSE)
hpc <- tbl_df(data) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")
png(filename="plot1.png", width=480, height=480, units="px")
hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
