SELECT yearID, lgID, SUM(G), SUM(R), SUM(R)/SUM(G) 
FROM Teams 
WHERE yearID > 1900
GROUP BY yearID, lgID;
