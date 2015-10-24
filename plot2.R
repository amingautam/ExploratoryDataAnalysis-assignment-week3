library(dplyr)

#This will download the file & unzip it in your work directory - check with getwd()
#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
#unzip("./exdata_data_NEI_data.zip")

#loading of data
#NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#2. Have total emissions from PM2.5 decreased in the 
#Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

distEmmPerYearBalti <-  NEI %>% filter(fips == "24510") %>% group_by(year) %>% select(year,Emissions) %>% summarise_each(funs(sum))

#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot2.png", width = 480, height = 480,units = "px")
#Plot2
plot(distEmmPerYearBalti$year,distEmmPerYearBalti$Emissions, type = "l" , xlab="Year" , ylab = "Emissions", axes=FALSE)
axis(1, at=distEmmPerYearBalti$year)
axis(2, at=distEmmPerYearBalti$Emissions, las=2)
dev.off()