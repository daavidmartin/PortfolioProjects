SELECT *
FROM PortfolioProject..CovidDeaths
WHERE Continent is not NULL
ORDER BY 3,4


--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select Data that we will be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
WHERE Continent is not NULL
order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
WHERE Location like '%states%'
AND Continent is not NULL
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population has got covid

SELECT Location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
 --WHERE Location like '%states%'
order by 1,2

-- Looking at countires with Highest Infection Rate compared to Popoulation

SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
 --WHERE Location like '%states%'
 Group By Location, population
order by  PercentPopulationInfected desc

-- Showing Countries with Highest Death Count Per Population

SELECT Location, MAX(cast(Total_Deaths as int)) as  TotalDeathCount
From PortfolioProject..CovidDeaths
 --WHERE Location like '%states%'
 WHERE Continent is not NULL
 Group By Location
order by TotalDeathCount desc


--LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing the Continents with the Highest death count per Population

SELECT continent , MAX(cast(Total_Deaths as int)) as  TotalDeathCount
From PortfolioProject..CovidDeaths
 --WHERE Location like '%states%'
 WHERE Continent is Not NULL
 Group By continent
order by TotalDeathCount desc




-- GLOBAL NUMBERS

SELECT SUM(New_cases)as total_cases, SUM(cast(new_deaths as int))as total_deaths, SUM(cast(New_deaths as int ))/SUM(New_Cases) *100 as DeathPercentage
From PortfolioProject..CovidDeaths
--WHERE Location like '%states%'
WHERE Continent is not NULL
--GROUP By date 
order by 1,2

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,  (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
	WHERE dea.continent is not NULL
order by 2,3

--USE CTE

With PopvsVac (Continent,Location,Date,Population,New_Vaccinations,RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,  (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
	WHERE dea.continent is not NULL
--order by 2,3
)
SELECT *, (RollingPeopleVaccinated/Population)*100
From PopVsVac


-- Temp Table

DROP Table if exists #PercentPopulationVaccinated
CREATE TABLE  #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,  (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
--	WHERE dea.continent is not NULL
--order by 2,3

SELECT *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

-- Creating View to Store data for later visualizations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location,dea.date) as RollingPeopleVaccinated
--,  (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent is not NULL
-- order by 2,3

select *
From PercentPopulationVaccinated


