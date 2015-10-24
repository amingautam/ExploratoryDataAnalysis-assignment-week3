library(dplyr)
library(ggplot2)

#This will download the file & unzip it in your work directory - check with getwd()
#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
#unzip("./exdata_data_NEI_data.zip")

#loading of data
#NEI <- readRDS("./summarySCC_PM25.rds")
#SCC <- readRDS("./Source_Classification_Code.rds")

#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions 
#from 1999???2008 for Baltimore City? Which have seen increases in emissions
#from 1999???2008? Use the ggplot2 plotting system to make a plot answer this 
#question.

distEmmPerYearBaltiDiffSrcs <-  NEI %>% filter(fips == "24510") %>% select(type,year,Emissions) %>% group_by(year,type) %>% summarise_each(funs(sum))


#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot3.png", width = 480, height = 480,units = "px")
#Plot3
qplot(year, Emissions, data = distEmmPerYearBaltiDiffSrcs, geom = c("point", "line"), colour = type)
dev.off()