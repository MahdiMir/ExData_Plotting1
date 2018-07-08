#========== Setting working directory ==========================
setwd("/D @ Win/Data Science/04-Exploratory DA")
if (!file.exists("data")) {
        dir.create("data")
}

#========== Reading, Subsetting and Formatting Data ============
pwrdb <- read.csv("data/household_power_consumption.txt", header=T, sep=';',
                  na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F,
                  comment.char="", quote='\"')

udb <- subset(pwrdb, Date %in% c("1/2/2007", "2/2/2007"))
udb$Date <- as.Date(udb$Date, format = "%d/%m/%Y")
datetime <- paste(as.Date(udb$Date), udb$Time)
udb$datetime <- as.POSIXct(datetime)

#========== Building, Labeling and Publishing the Plot =========
par(mfrow=c(2,2))

with(udb, {
        plot(Global_active_power~datetime, type="l", 
                ylab = "Global Active Power", xlab="")
        
        plot(Voltage~datetime, type="l", 
                ylab = "Voltage", xlab="datetime")

        plot(Sub_metering_1~datetime, type="l", 
             ylab = "Energy Sub Metering", xlab="")
        lines(Sub_metering_2~datetime, col = "Red")
        lines(Sub_metering_3~datetime, col = "Blue")

        legend("topright", col=c("black", "red", "blue"), bty = "n", lty=1, lwd=2, 
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Global_reactive_power~datetime, type="l", xlab="datetime")

})

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()