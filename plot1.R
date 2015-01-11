# just read the relevant dates - line number are quickly found in VIM
df <- read.table("household_power_consumption.txt",skip=66637, nrows = 69517-66637,
                 sep=';', na.strings='?')

#df <- read.table("household_power_consumption.txt",
#                 sep=';', na.strings='?', header=TRUE)

# add the header to the read data frame
colnames(df) <- colnames(read.table("household_power_consumption.txt", nrows=1, sep=";", header=TRUE))

# convert the Date columns to datetime
df$Date <- as.Date(df$Date,'%d/%m/%Y')
df$Timestamp <- strptime(paste(df$Date,df$Time),'%Y-%m-%d %H:%M:%S')

# plot and save the png
png(file='plot1.png', height=480, width=480)
hist(df$Global_active_power, col='red', xlab='Global Active Power (kilowatts)',
     main='Global Active Power')
dev.off()