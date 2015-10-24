library(dplyr)

#This will download the file & unzip it in your work directory - check with getwd()
#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
#unzip("./exdata_data_NEI_data.zip")

#loading of data
#NEI <- readRDS("./summarySCC_PM25.rds")
#SCC <- readRDS("./Source_Classification_Code.rds")

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from
#all sources for each of the years 1999, 2002, 2005, and 2008

distEmmPerYear <-  NEI %>% group_by(year) %>% select(year,Emissions) %>% summarise_each(funs(sum))


#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot1.png", width = 480, height = 480,units = "px")
#Plot1

plot(distEmmPerYear$year,distEmmPerYear$Emissions, type = "l" , xlab="Year" , ylab = "Emissions", axes=FALSE)
axis(1, at=seq(1998,2009,by=1))
axis(2, at=seq(0,80000000,by=1000000), las=2)
dev.off()