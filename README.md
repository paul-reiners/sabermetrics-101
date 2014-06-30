Why did the Players League have so many R/G?
--------------------------------------------
In the "Different Eras IV" video, Professor Andres asked

> Maybe there's a difference here with the Players League. It might be
> different than the other leagues in that era, that actual year. But
> it's hard to tell. And again, if you're interested in this, seeing
> this difference, you might explore it. What could be the potential
> cause for this difference? Do you think it actually is a significant
> difference or not?

Here is a zoomed-in plot showing this:

![enter image description here][1]

I decided to investigate this question.  Recall that the Players League lasted for only one year, 1890.  I thought that the reason might be that the players in the Players League were simply better than the players in the other leagues.  To test this hypothesis, I did the following:

1. Found those players that batted in the Players League and who also batted (in some other league) in the year before, 1889, and in the year after, 1891.
2. Found the ratio for each hitter between their R/G in the PL and their R/G in the preceding and succeeding years.
3. Took the mean of all these ratios

The mean of ratios was 1.2360.  So these players had higher R/G records in the PL than they had in other leagues.  That is, **any player who played in the PL, on average, had 1.2360 times as many R/G as he had when he was in a league other than the PL.** 

For brevity, let's call this ratio the "PL advantage".  

Now a certain number of these players probably just happened to reach their peak year in 1890.  How many players would this be?  The average career length for an MLB player is currently 5.6 years.  So 1 / 5.6 players would be at their peak in 1890.  What happens if we eliminate the top 1 / 5.6 of the players (ordered descending by their PL advantage) from our data pool?  If we do, then the ratio is 1.2257.  This is still significant.

It is still possible that part of the reason for the higher R/G is because there were better players in the PL.  This is something I plan on looking at.  But at least part of the reason, as I established above, is that players had more R/G in the PL than they had in the other leagues in the two years surrounding the year of the PL.

So what was going on in the PL that caused players to have a higher R/G.  Here are a couple things that might have been different in the PL than the other leagues in 1890:

 - Rules
 - Parks

These are things I would like to look at when I have time.

You can see my code and a derived table here: 

 - [SQL](https://github.com/paul-reiners/sabermetrics-101/blob/master/src/PlayerRecords.sql)
 - [R](https://github.com/paul-reiners/sabermetrics-101/blob/master/src/player_records.R)
 - [table](https://github.com/paul-reiners/sabermetrics-101/blob/master/data/PlayerRecords.csv)

I encourage people to look at my code and let me know if you find any problems or anything that can be improved.

My next task will be to establish whether PL players had higher R/G than non-PL players on average.


  [1]: https://edxuploads.s3.amazonaws.com/14029396968096377.png
  
Perhaps the problem was that the pitching wasn't so hot?

The ERA for the PL was definitely higher than that of the AA and NL:

    SELECT yearID, lgID, AVG(ERA)
    FROM Teams 
    WHERE 1889 <= yearID AND yearID <= 1891
    GROUP BY yearID, lgID;

    yearID        lgID	AVG(ERA)
    1889	AA	3.845
    1889	NL	4.0325
    1890	AA	3.91777777778
    1890	NL	3.5625
    1890	PL	4.23875
    1891	AA	3.61333333333
    1891	NL	3.34375

However, ERA is sort of the flip side of the coin of R/G, I would think.  So I'm not sure this proves anything.  Is there a measure of pitching ability that would work better?  

I need to do the following:

 - Decide on a pitching stat(s) similar to R/G batting stat.  Perhaps this is ERA; perhaps not.
 - Compare the performance of PL pitchers with their performance in other leagues in 1889 and 1891 (for those pitchers who pitched in the majors all three seasons).

So here is a plot of league ERAs:

![League ERAs][1]

Yes, the ERA was significantly higher for the PL.  So you could say the pitching was worse in the PL.  Or is this caused by the batting being better in the PL?

  [1]: https://edxuploads.s3.amazonaws.com/1402940587400911.png

Handedness in Canadian-born players versus U.S.-born players
------------------------------------------------------------

I know that Canadian-born hockey players tend to mostly shoot left-handed while U.S.-born hockey players tend to shoot right-handed.  There was an [article in the NY Times][1] about this a few years ago.  

I wondered if this carried over to batting.  It does.

             B    L    R
      CAN   10   96  104
      USA  881 4115 9454

If whether you bat left- or right-handed is somewhat independent of which is your dominant hand, then it follows that which way you bat is a learned skill.  (I'm assuming that the distribution of hand dominance in ball players is the same as it is in the general population, but I don't know that for a fact.)

From that it seems to follow that you could be taught (at least if you started young enough) to be a switch-hitter.

Here is the SQL code:

    SELECT playerID, birthCountry, bats
    FROM baseball.master

Here is the R code:

    handedness <- read.csv("./data/handedness.csv")
    table(handedness$birthCountry, handedness$bats)


  [1]: http://www.nytimes.com/2010/02/16/sports/olympics/16lefty.html
