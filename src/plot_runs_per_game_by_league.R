league.data <- read.csv("./data/runs_per_game.csv")
colnames(league.data) <- c("year", "league", "games", "runs", "runs.per.game")

library(lattice)
xyplot(runs.per.game ~ year, groups=league.data$league, data = league.data, 
       auto.key = list(corner = c(0, .98)), cex = 1.5)
