league.data <- read.csv("./data/pl_runs_per_game/runs_per_game.csv")
colnames(league.data) <- c("year", "league", "games", "runs", "runs.per.game")
league.data <- subset(league.data, 1885 <= year & year <= 1895)

library(ggplot2)
g <- ggplot(league.data, aes(year, runs.per.game)) 
summary(g)
g + geom_point (aes(color=league), size = 3) + 
        geom_smooth(method="lm") + ylab("runs per game") +
        scale_x_continuous(breaks=seq(1885, 1895, 1))
