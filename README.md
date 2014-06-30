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
