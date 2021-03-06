#check if the package has been installed.
check<-function(pkgname){
        if (is.na(match(pkgname,rownames(installed.packages())))) {
                install.packages(pkgname)
        }
}

check("data.table")
check("lubridate")

library(data.table)
library(lubridate)

#read data with fread() function, which is fast.
power <- fread("household_power_consumption.txt", na.string = "?")

#subset the data.
power <- power[Date == '1/2/2007' | Date == '2/2/2007',]

#rename the data to make it easy to use.
names(power)<-c("date","time","gap","grp","vol","gi","sm1","sm2","sm3")

#combine data and time column, assign the value to time column.
power$time <- with(power, paste(date, time))

#date column is duplicated now, so delete it.
power <- power[, -1, with = F]

#read time column in a way that R understands.
power$time <- dmy_hms(power$time)

#draw plot2.
with(power, plot(gap ~ time, type = "l", xlab = "", ylab= "Global Active Power (kilowatts)"))

#save plot2.png.
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()