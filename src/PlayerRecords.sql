SELECT playerID, yearID, stint, teamID, lgID, G_batting, R, R/G_batting AS runsPerGame 
FROM Batting b
WHERE 1889 <= yearID AND yearID <= 1891 # AND lgID = "PL"
