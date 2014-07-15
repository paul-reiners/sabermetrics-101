mauer <- read.csv("./data/mauer/mauer.csv")
past <- mauer[mauer$Year != 2014,]
summary(past$OPS)
sd(past$OPS)
plot(y=mauer$OPS, x=mauer$Year, xlab="Year", ylab="OPS", main="Joe Mauer", type="l")
library("ggplot2")
qplot(Year, OPS, data = mauer) + geom_smooth()
