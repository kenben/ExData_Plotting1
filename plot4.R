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

png(file='plot4.png', height=480, width=480)
par(mfcol=c(2,2))

# first plot
plot(df$Timestamp, df$Global_active_power, xlab='', type='n',
     ylab='Global Active Power')
lines(df$Timestamp,df$Global_active_power)

# second plot
plot(df$Timestamp, df$Sub_metering_1, xlab='', type='n',
     ylab='Energy sub metering')
lines(df$Timestamp,df$Sub_metering_1)
lines(df$Timestamp,df$Sub_metering_2, col='red')
lines(df$Timestamp,df$Sub_metering_3, col='blue')
legend('topright', col=c('black','red','blue'), lty=c(1,1,1), bty='n',
       legend=colnames(df)[7:9])

# third plot
plot(df$Timestamp, df$Voltage, xlab='datetime', type='n',
     ylab='Voltage')
lines(df$Timestamp,df$Voltage)

# fourth plot
plot(df$Timestamp, df$Global_reactive_power, xlab='datetime', type='n')
lines(df$Timestamp,df$Global_reactive_power)

dev.off()