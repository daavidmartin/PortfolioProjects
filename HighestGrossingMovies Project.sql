-- Select Data that we will be Using

SELECT Title, Distributor, [Release Date], [Domestic Sales (in $)], [International Sales (in $)], [World Sales (in $)], Genre
, [Movie Runtime], License
FROM PortfolioProject3..HighestGrossingMovies

--Showing movies that have supassed 1 billion sales worldwide

SELECT Title, [World Sales (in $)]
FROM PortfolioProject3..HighestGrossingMovies
WHERE [World Sales (in $)] > 1000000000 
ORDER BY [World Sales (in $)] desc

--Showing Average Sales Per Distributor

SELECT DISTINCT Distributor, AVG([World Sales (in $)]) AS AverageSalesPerDistributor
FROM PortfolioProject3..HighestGrossingMovies
GROUP BY Distributor
