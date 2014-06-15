SELECT yearID, lgID, SUM(G), SUM(R), SUM(R)/SUM(G) 
FROM Teams 
GROUP BY yearID, lgID;
