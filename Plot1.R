#========== Setting working directory ==========================
setwd("/D @ Win/Data Science/04-Exploratory DA")
if (!file.exists("data")) {
        dir.create("data")
}

#========== Reading and Subsetting Data ========================
pwrdb <- read.csv("data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                  nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
udb <- subset(pwrdb, Date %in% c("1/2/2007", "2/2/2007"))
udb$Date <- as.Date(udb$Date, format = "%d/%m/%Y")

#========== Building and Publishing the Plot ===================
hist(udb$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", col = "red")

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
