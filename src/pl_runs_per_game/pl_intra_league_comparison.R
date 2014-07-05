# Author: Paul Reiners

player.records <- read.csv("./data/all_batting_player_records.csv", stringsAsFactors = FALSE)
player.records$runsPerGame <- NULL

# Did any player in 1890 move from PL to non-PL league or vice-versa?
player.records.1890 <- subset(player.records, yearID == 1890)
found.crossover <- F
for (i in 1:(nrow(player.records.1890) - 1))
{
        row1 <- player.records.1890[i, ]
        row2 <- player.records.1890[i + 1, ]
        if (row1[[1]] == row2[[1]]) 
        {
                if ((row1[[4]] == "PL" & row2[[4]] != "PL") | (row1[[4]] != "PL" & row2[[4]] == "PL")) 
                {
                        found.crossover <- T
                        print(paste(row1[[1]], " transferred between PL and non-PL."))
                        
                        break
                }
        }
}

if (found.crossover) print("Found crossover.") else print(" Didn't find crossover.")

pl.players <- unique(subset(player.records, lgID == "PL")$playerID)

# Collapse across stints
require(plyr)
attach(player.records)
player.records <- ddply(player.records, c("playerID", "yearID"), summarize,
      G_batting = sum(G_batting),
      R = sum(R))

players.1889 <- subset(player.records, yearID == 1889)
pl.1889.rows <- players.1889$playerID %in% pl.players

players.1889.pl <- players.1889[pl.1889.rows == T, ]
players.1889.pl.rg <- sum(players.1889.pl$R) / sum(players.1889.pl$G_batting)
print(paste("1889 PL players R/G:", round(players.1889.pl.rg, 2)))

players.1889.non.pl <- players.1889[pl.1889.rows == F, ]
players.1889.non.pl.rg <- sum(players.1889.non.pl$R) / sum(players.1889.non.pl$G_batting)
print(paste("1889 non-PL players R/G:", round(players.1889.non.pl.rg, 2)))

players.1891 <- subset(player.records, yearID == 1891)
pl.1891.rows <- players.1891$playerID %in% pl.players

players.1891.pl <- players.1891[pl.1891.rows == T, ]
players.1891.pl.rg <- sum(players.1891.pl$R) / sum(players.1891.pl$G_batting)
print(paste("1891 PL players R/G:", round(players.1891.pl.rg, 2)))

players.1891.non.pl <- players.1891[pl.1891.rows == F, ]
players.1891.non.pl.rg <- sum(players.1891.non.pl$R) / sum(players.1891.non.pl$G_batting)
print(paste("1891 non-PL players R/G:", round(players.1891.non.pl.rg, 2)))

players.all.pl <- rbind(players.1889.pl, players.1891.pl)
players.all.pl.rg <- sum(players.all.pl$R) / sum(players.all.pl$G_batting)
print(paste("PL players R/G:", round(players.all.pl.rg, 2)))

players.all.non.pl <- rbind(players.1889.non.pl, players.1891.non.pl)
players.all.non.pl.rg <- sum(players.all.non.pl$R) / sum(players.all.non.pl$G_batting)
print(paste("Non-PL players R/G:", round(players.all.non.pl.rg, 2)))

print(paste("PL to non-PL ratio:", round(players.all.pl.rg / players.all.non.pl.rg, 2)))
