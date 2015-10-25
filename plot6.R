library(dplyr)
library(ggplot2)

#This will download the file & unzip it in your work directory - check with getwd()
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
unzip("./exdata_data_NEI_data.zip")

#loading of data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Assumption: based on some exploration I realised that 'Short.Name' was the best field to filter for 
#'motor vehicles' related sources. The best search string is 'vehicle'.
vehicle <- SCC %>% filter(grepl("vehicle",Short.Name ,ignore.case=TRUE))
distEmmPerYearVehicle <- NEI %>% filter(SCC %in% vehicle$SCC)
distEmmPerYearVehicleMerge <- merge(distEmmPerYearVehicle,vehicle, by.x="SCC", by.y="SCC") %>% filter(fips == "24510" | fips == "06037")
distEmmPerYearVehicleMergeBaltiCali <- distEmmPerYearVehicleMerge %>% select(year,fips,Emissions) %>% mutate(fips = ifelse(fips=="06037","Los Angeles County","Baltimore City")) %>% group_by(year,fips) %>% summarise_each(funs(sum))



#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot6.png", width = 480, height = 480,units = "px")
#Plot6
qplot(year, Emissions, data = distEmmPerYearVehicleMergeBaltiCali, geom = c("point", "line"), colour = fips)
dev.off()