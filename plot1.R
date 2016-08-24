#check if the package has been installed.
check<-function(pkgname){
        if (is.na(match(pkgname,rownames(installed.packages())))) {
                install.packages(pkgname)
        }
}
check("data.table")

library(data.table)

#read data with fread (it is fast).
power <- fread("household_power_consumption.txt", na.string = "?")

#subset data.
power <- power[Date == '1/2/2007' | Date == '2/2/2007',]

#rename data to make it easy to use.
names(power)<-c("date","time","gap","grp","vol","gi","sm1","sm2","sm3")

#draw plot1
hist(power$gap, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#save the plot to a png file.
dev.copy(png, "plot1.png",width = 480, height = 480)
dev.off()