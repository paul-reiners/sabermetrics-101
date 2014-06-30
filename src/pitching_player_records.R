# Author: Paul Reiners

player.records <- read.csv("./data/pitching_player_records.csv", stringsAsFactors = FALSE)
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

library(plyr)
player.records <- ddply(player.records, 
                        c("playerID", "yearID"), summarise,
               ERA    = mean(ERA),
               WHIP = mean(WHIP))

library(reshape2)

player.records$lgID <- NULL
player.records$WHIP <- NULL
data.wide <- dcast(player.records, playerID ~ yearID, value.var="ERA")
colnames(data.wide) <- c("playerID","ERA.1889", "ERA.1890", "ERA.1891" )

print(paste("1889 mean ERA: ", mean(data.wide$ERA.1889)))
print(paste("1890 mean ERA: ", mean(data.wide$ERA.1890)))
print(paste("1891 mean ERA: ", mean(data.wide$ERA.1891)))
