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

# open file and plot
png(file='plot2.png', height=480, width=480)
plot(df$Timestamp, df$Global_active_power, xlab='', type='n',
     ylab='Global Active Power (kilowatts)')
lines(df$Timestamp,df$Global_active_power)
dev.off()