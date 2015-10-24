library(dplyr)
library(ggplot2)

#This will download the file & unzip it in your work directory - check with getwd()
#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(url=fileurl,destfile="./exdata_data_NEI_data.zip",method="curl")
#unzip("./exdata_data_NEI_data.zip")

#loading of data
#NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

#4. Across the United States, how have emissions from coal combustion-related
#sources changed from 1999???2008?

#Assumption: based on some exploration I realised that 'Short.Name' was the best field to filter for 
#'coal combustion-related' related sources.
coal <- SCC %>% filter(grepl("Coal",Short.Name ,ignore.case=TRUE))
distEmmPerYearCoal <- NEI %>% filter(SCC %in% coal$SCC)
distEmmPerYearCoalMerge <- merge(distEmmPerYearCoal,coal, by.x="SCC", by.y="SCC") %>% select(year,Emissions) %>% group_by(year) %>% summarise_each(funs(sum))



#Construct the plot and save it to a PNG file in your work directory with a width of 480 pixels and a height of 480 pixels.
png(filename="plot4.png", width = 480, height = 480,units = "px")
#Plot4
qplot(year, Emissions, data = distEmmPerYearCoalMerge, geom = c("point", "line"))
dev.off()