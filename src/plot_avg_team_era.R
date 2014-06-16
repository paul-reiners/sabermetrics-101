league.data <- read.csv("./data/avg_team_era.csv")
colnames(league.data) <- c("year", "league", "era")
league.data <- subset(league.data, 1887 <= year & year <= 1893)

library(ggplot2)
g <- ggplot(league.data, aes(year, era)) 
summary(g)
g + geom_point (aes(color=league), size = 3) + 
        geom_smooth(method="lm") + ylab("ERA") +
        scale_x_continuous(breaks=seq(1887, 1893, 1))
