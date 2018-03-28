# Vania Tso
# Project 3, Part 2

rm(list=ls()) # clear environment
load("~/Downloads/dfColleyMatrix.Rda") # load data set
tempdf <- dfColley

colley <- function(year){
  tempdf <- dfColley[which(dfColley$season == year),]   # set a dataframe for one season according to input
  numTeams <- dim(tempdf)[1]
  # A Matrix
  A <- matrix(NA, nrow=numTeams, ncol=numTeams) # empty matrix
  for(i in 1:numTeams) { # counts rows
    for(j in 1:numTeams) { # counts columns
      if(i == j) { # if diagonal
        numGames <- length(tempdf$opp[[i]]) # number of games played
        A[i,j] <- 2 + numGames # adds value to related diaognal entry
      } else{
        count = 0 # initialize count variable
        temp <- tempdf$opp[[i]] # list of opponents for that team/row
        for(z in 1:length(temp)){
          if(temp[z] == j){ # checks if the opponent value is equal to that col value
            count = count + 1 # keeps a tally if opponent matches
          }
        }
        A[i,j] <- -1 * count # adds count value to off diagonal entry
      }
    }
  }
  # b vector
  b <- matrix(1+(tempdf$wins - tempdf$losses)/2,nrow=numTeams)
  # x vector
  x <- solve(A,b)
  # create new data frame, "solution"
  solution <- data.frame(tempdf$names, x)
  solution <- solution[order(-x),] # ordered according to score
  colnames(solution) <- c("Team", "Score")

  return(solution)
}
