setwd("~/Dropbox/education/EdX/BUx/SABR101/sabermetrics-101")
handedness <- read.csv("./data/handedness.csv")
table(handedness$birthCountry, handedness$bats)
