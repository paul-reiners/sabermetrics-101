league.data <- read.csv("./data/runs_per_game.csv")
colnames(league.data) <- c("year", "league", "games", "runs", "runs.per.game")

library(ggplot2)
g <- ggplot(league.data, aes(year, runs.per.game)) 
summary(g)
g + geom_point (aes(color=league), size = 3) + 
        geom_smooth(method="lm") + ylab("runs per game") +
        scale_x_continuous(breaks=seq(1870, 2010, 20))
