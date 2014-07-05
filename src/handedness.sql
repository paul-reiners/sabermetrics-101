SELECT playerID, birthCountry, bats
FROM baseball.master
INTO OUTFILE '/tmp/handedness.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';