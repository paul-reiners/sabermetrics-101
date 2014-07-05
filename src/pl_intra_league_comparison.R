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
