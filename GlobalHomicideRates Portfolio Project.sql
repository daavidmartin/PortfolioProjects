-- Selecting data we will be using

SELECT Location, Region, Rate, Count, Year
FROM PortfolioProject4..['countriesbyintentionalhomicide']

-- Displaying Country of homicide rate, Substitute 'United States' for any country

SELECT Location, Region, Rate, Count, Year
FROM PortfolioProject4..['countriesbyintentionalhomicide']
WHERE Location like 'United States'

-- Showing Homicide Percentage by Region

SELECT DISTINCT Region, AVG(Rate) as HomicidePerectage
FROM PortfolioProject4..['countriesbyintentionalhomicide']
WHERE Region = 'Americas' OR Region = 'Africa' OR Region = 'Asia' OR Region = 'Europe' OR Region = 'Oceania'
GROUP BY REGION
ORDER BY HomicidePerectage DESC

-- Displaying Highest Homicide Count by Country 

SELECT Location, Rate, Count, Year
FROM PortfolioProject4..['countriesbyintentionalhomicide']
ORDER BY COUNT DESC

-- Displaying Highest Homicide Rate By Country

SELECT Location, Rate, Year
FROM PortfolioProject4..['countriesbyintentionalhomicide']
ORDER BY RATE DESC

-- Showing Homicide Count by Region

SELECT DISTINCT Region, SUM(COUNT) as HomicideCount
FROM PortfolioProject4..['countriesbyintentionalhomicide']
WHERE Region = 'Americas' OR Region = 'Africa' OR Region = 'Asia' OR Region = 'Europe' OR Region = 'Oceania'
GROUP BY REGION
ORDER BY HomicideCount DESC 
