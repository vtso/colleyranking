# Colley Ranking
Course exercise to rank university football teams based on the Colley Method (Colley, 2002).

## Components
Part 1 web scrapes historical data by James Howell on college football games and their outcomes from 1961 - 2010. It formats the data into a Colley matrix with the columns: "season," "names," "wins," "losses," "opp." "names" represents a division 1 team during that particular season. "wins" ("losses") indicates the number of games that team won (lost). "opp" provides a list of teams that the team played against. The numbers in the list references the index of the team. Games ending in ties are not counted or recorded into the new data frame. The script outputs an R data file: dfColleyMatrix.Rda .

Part 2 reads in the data file created from Part 1 and contains a function that ranks the college teams based on the Colley Method given a year between 1961 to 2010. For example: "colley(1989)" will return a list of the teams in 1989 with their Colley scores, ranked by the Colley scores calculated within the function.

### More information
The project references Colley's Bias Free College Football Ranking Method: The Colley Matrix Explained (Colley, 2002).
See https://www.colleyranking.com/method.html/ . 

Data by James Howell listed by year found at http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/ .

Completed for Cal Poly SLO, GSE 524 Course taught by Dr. Aric Shafran.

