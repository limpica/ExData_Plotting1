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

#draw plot 3 and save it.
png("plot3.png", width = 480, height = 480)
with(power, {
        plot(sm1 ~ time, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(sm2 ~ time, col = "red")
        lines(sm3 ~ time, col = "blue")
        legend(
                "topright",
                lty = 1,
                col = c("black", "blue", "red"),
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        )
}
)

dev.off()


