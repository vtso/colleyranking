# Colley Ranking
Course exercise to rank university football teams based on the Colley Method (Colley, 2002). The Colley ranking method was created out of the need for a more reliable, bias-free system to choose football teams that would play in the playoffs and subsequently, the championship game. The method uses only wins and losses as inputs.

## Components
This project is split into 2 parts:

Part 1 web scrapes historical data by James Howell on college football games and their outcomes from 1961 - 2010. It formats the data, to be calculated into a Colley matrix, with the columns: "season," "names," "wins," "losses," "opp." "names" represents a division 1 team during that particular season. "wins" ("losses") indicates the number of games that team won (lost). "opp" provides a list of teams that the team played against. The numbers in the list references the index of the team. Games ending in ties are not counted or recorded into the new data frame. The script outputs an R data file: dfColleyMatrix.Rda .

Part 2 reads in the data file created from Part 1 and contains a function that when given a year between 1961 to 2010, ranks the college teams by implementing the Colley Matrix Method. For example: "colley(1989)" will return a list of the teams in 1989 with their Colley scores, ranked by the Colley scores calculated within the function.

### More information
The project is based entirely on Colley's Bias Free College Football Ranking Method: The Colley Matrix Explained (Colley, 2002).
See https://www.colleyranking.com/method.html/ . 

Data by James Howell listed by year found at http://homepages.cae.wisc.edu/~dwilson/rsfc/history/howell/ .

Completed for Cal Poly SLO, GSE 524 Course taught by Dr. Aric Shafran.

