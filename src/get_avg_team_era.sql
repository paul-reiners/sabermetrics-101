SELECT yearID, lgID, AVG(ERA) 
FROM Teams 
WHERE 1887 <= yearID AND yearID <= 1893
GROUP BY yearID, lgID;
