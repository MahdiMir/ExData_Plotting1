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

#========== Building and Publishing the Plot ===================
with(udb, {plot(Global_active_power~datetime, type="l", 
                ylab = "Global Active Power (Kilowattes)", xlab="")})

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
