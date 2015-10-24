library(dplyr)
library(ggplot2)

#This will download the file & unzip it in your work directory - check with getwd()
#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
#unzip("./exdata_data_NEI_data.zip")

#loading of data
#NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#5. How have emissions from motor vehicle sources changed from 1999???2008 in 
#Baltimore City?

#Assumption: based on some exploration I realised that 'Short.Name' was the best field to filter for 
#'motor vehicles' related sources. The best search string is 'vehicle'.
vehicle <- SCC %>% filter(grepl("vehicle",Short.Name ,ignore.case=TRUE))
distEmmPerYearVehicle <- NEI %>% filter(SCC %in% vehicle$SCC)
distEmmPerYearVehicleMerge <- merge(distEmmPerYearVehicle,vehicle, by.x="SCC", by.y="SCC") %>% filter(fips == "24510")
distEmmPerYearVehicleMergeBalti <- distEmmPerYearVehicleMerge %>% select(year,Emissions) %>% group_by(year) %>% summarise_each(funs(sum))



#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot5.png", width = 480, height = 480,units = "px")
#Plot5
qplot(year, Emissions, data = distEmmPerYearVehicleMergeBalti, geom = c("point", "line"))
dev.off()