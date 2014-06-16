SELECT playerID, yearID, stint, teamID, lgID, ERA, (p.BB + p.H) / (p.IPOuts / 3) AS WHIP
FROM Pitching p
WHERE 1889 <= yearID AND yearID <= 1891 
