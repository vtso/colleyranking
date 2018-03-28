# Vania Tso
# Project 3, Part 1

rm(list = ls())
frontLink <- "http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/cf"
backLink <- "gms.txt"
df <- data.frame() # create dataframe to store raw data
tempdf <- data.frame()
start <- 1961
finish <- 2010
for(i in start:finish){
  date <- i
  fullLink <- paste(frontLink,date,backLink, sep='') # create link based on year
  tempdata <- readLines(fullLink)
  n <- length(tempdata)
  for(j in 1:n){
    temp <- tempdata[j]
    tempdf[j,1] <- i
    tempdf[j,2] <- substr(temp, 12, 39)
    tempdf[j,3] <- substr(temp, 40, 41)
    tempdf[j,4] <- substr(temp, 43, 68)
    tempdf[j,5] <- substr(temp, 72, 73)
  }
  df <- rbind(df, tempdf)
}

# Clean up df
# Rename colnames
colnames(df) <- c("Season", "AwayTeam", "AwayScore", "HomeTeam", "HomeScore")
# Make score columns numeric
df$AwayScore <- as.numeric(df$AwayScore)
df$HomeScore <- as.numeric(df$HomeScore)
# take out white spaces in team names
df$AwayTeam <- trimws(df$AwayTeam, which=c("both", "left", "right"))
df$HomeTeam <- trimws(df$HomeTeam, which=c("both", "left", "right"))
# order in ascending order by Season
df <- df[order(df$Season),]

# Use raw data to reformat it to be used to calculate Colley scores
# Create data set for colley matrix data for all seasons
dfColley <- data.frame("season"=numeric(), "names"= character(), "wins"= numeric(),
                       "losses"= numeric(), "opp"= numeric())
# look at data by season
for(year in start:finish){
  oneSeason <- df[which(df$Season == year),]   # set a dataframe for one season
  names <- unique(c(oneSeason$AwayTeam, oneSeason$HomeTeam)) # store names of all teams
  # hash table for team names in this particular season
  teamsenv <- new.env()
  numTeams <- length(names)
  for(i in 1:numTeams){
    teamsenv[[names[i]]] <- i
  }
  # dataframe to track number of times a team has played
  gamesPlayed <- data.frame(names, "games"= numeric(numTeams), "wins"= numeric(numTeams),
                            "losses"= numeric(numTeams), "opp"= numeric(numTeams))
  obs <- dim(oneSeason)[1]
  for(i in 1:obs){
    idAway <- teamsenv[[oneSeason$AwayTeam[i]]]
    idHome <- teamsenv[[oneSeason$HomeTeam[i]]]
    # tally total number of games
    gamesPlayed$games[idAway] <- gamesPlayed$games[idAway] + 1
    gamesPlayed$games[idHome] <- gamesPlayed$games[idHome] + 1
  }
  # store names of D2 teams
  D2 <- as.character(gamesPlayed$names[which(gamesPlayed$games<6)])
  # take out D2 teams from that season
  len <- length(D2)
  i <- 1
  for(i in 1:len){
    index <- c(grep(paste(D2[i],"$", sep=""), oneSeason$AwayTeam),
               grep(paste(D2[i],"$", sep=""), oneSeason$HomeTeam))
    if(length(index)>0){
      oneSeason <- oneSeason[-c(index),]
    }
  }
  # drop ties
  oneSeason <- oneSeason[!(oneSeason$AwayScore==oneSeason$HomeScore),]
  # new hash table for oneSeason data
  names <- unique(c(oneSeason$AwayTeam, oneSeason$HomeTeam)) # store names of all teams
  # hash table for team names in this particular season
  D1env <- new.env()
  numTeams <- length(names)
  for(i in 1:numTeams){
    D1env[[names[i]]] <- i
  }
  
  # Create Colley matrix for this season
  season <- rep(year, numTeams)
  wins <- rep(0, numTeams)
  losses <- rep(0, numTeams)
  opp <- rep("", numTeams)
  oneColley <- data.frame(season, names, wins, losses, opp)
  oneColley$opp <- as.list(oneColley$opp)
  obs <- dim(oneSeason)[1]
  for(i in 1:obs){
    idAway <- D1env[[oneSeason$AwayTeam[i]]]
    idHome <- D1env[[oneSeason$HomeTeam[i]]]
    # count num wins/losses
    if(oneSeason$AwayScore[i] > oneSeason$HomeScore[i]){
      oneColley$wins[idAway] <- oneColley$wins[idAway] + 1
      oneColley$losses[idHome] <- oneColley$losses[idHome] + 1
    }
    else if(oneSeason$AwayScore[i] < oneSeason$HomeScore[i]){
      oneColley$wins[idHome] <- oneColley$wins[idHome] + 1
      oneColley$losses[idAway] <- oneColley$losses[idAway] + 1
    }
    # fill opponent list 
    oneColley$opp[[idAway]] <- c(oneColley$opp[[idAway]], idHome)
    oneColley$opp[[idHome]] <- c(oneColley$opp[[idHome]], idAway)
  } 
  
  # rbind to dfColley dataframe
  dfColley <- rbind(dfColley, oneColley)
}

# save Colley matrix data set
save(dfColley, file="~/Desktop/dfColleyMatrix.Rda")