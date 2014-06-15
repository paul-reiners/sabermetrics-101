# Author: Paul Reiners

player.records <- read.csv("./data/player_records.csv", stringsAsFactors = FALSE)
players <- data.frame(unique(player.records$playerID))
colnames(players) <- c("playerID")

plRows <- player.records$lgID == "PL"
plPlayers <- player.records[plRows, ]
plPlayers <- unique(plPlayers$playerID)

the1889Rows <- player.records$yearID == 1889
the1889Players <- player.records[the1889Rows, ]
the1889Players <- unique(the1889Players$playerID)

the1891Rows <- player.records$yearID == 1891
the1891Players <- player.records[the1891Rows, ]
the1891Players <- unique(the1891Players$playerID)

threeYearPLPlayers <- intersect(plPlayers, the1889Players)
threeYearPLPlayers <- intersect(threeYearPLPlayers, the1891Players)

isThreeYearPLPlayer <- player.records$playerID %in% threeYearPLPlayers
player.records <- player.records[isThreeYearPLPlayer,]

nrow <- length(threeYearPLPlayers)
zeroes <- rep.int(0, 3 * nrow)
runs <- matrix(zeroes, nrow, 3)
games <- matrix(zeroes, nrow, 3)

for (i in 1:nrow(player.records)) {
        row <- player.records[i,]
        playerID <- row$playerID
        row.index <- match(playerID, threeYearPLPlayers)
        yearID <- row$yearID
        col.index <- yearID - 1889 + 1
        runs[row.index, col.index] <- runs[row.index, col.index] + row$R
        games[row.index, col.index] <- games[row.index, col.index] + row$G_batting
}

runs <- data.frame(runs)
colnames(runs) <- c("runs.1889", "runs.PL1890", "runs.1891")

games <- data.frame(games)
colnames(games) <- c("games.1889", "games.PL1890", "games.1891")

threeYearPLPlayers <- data.frame(threeYearPLPlayers)
colnames(threeYearPLPlayers) <- c("playerID")
results <- cbind(threeYearPLPlayers, runs, games)

results$runsPerGame.1889 <- results$runs.1889 / results$games.1889
results$runsPerGame.PL1890 <- results$runs.PL1890 / results$games.PL1890
results$runsPerGame.1891 <- results$runs.1891 / results$games.1891

results$PLImprovement <- results$runsPerGame.PL1890 / ((results$runsPerGame.1889 + results$runsPerGame.1891) / 2)

print(paste("Mean PL to non-PL R/G ratio", mean(results$PLImprovement)))
