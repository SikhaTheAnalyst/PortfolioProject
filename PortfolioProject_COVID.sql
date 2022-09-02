select * 
from PortfolioProject..Covid_Deaths
order by 3,4

--select *
--from PortfolioProject..Covid_Vaccinations
--order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject..Covid_Deaths
order by 1,2
select len(location) from PortfolioProject..Covid_Deaths

---selecting total_cases and total_deaths 
---showing the likelihood of dying if you contract covid
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from PortfolioProject..Covid_Deaths
where location='India'
order by 1,2

--selecting total cases and population

select location,date,total_cases,population,(total_cases/population)*100 as percentage_contracted
from PortfolioProject..Covid_Deaths
where location='India'
order by 1,2


--selecting countries having highest infection rate compared to population

select location,population,max(total_cases) as highest_infection_count, max(total_cases/population)*100 as highest_percentage_contracted
from PortfolioProject..Covid_Deaths
where continent is not null
group by location,population
order by highest_percentage_contracted desc

--selecting countries with highest death count per population

select location, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is not null
Group by location
order by TotalDeathCount desc
--lets break things down by continent
--correct one
select location, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is null
Group by location
order by TotalDeathCount desc
--showing the continents with highest death count
select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is not null
Group by continent
order by TotalDeathCount desc

select count(distinct(location))
from PortfolioProject.. Covid_Deaths
where continent like 'Oceania'

--creating views
--Global Numbers
select date,sum(new_cases) as TotalCase, sum(cast(new_deaths as int)) as Totaldeaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as death_percentage
from PortfolioProject..Covid_Deaths
where continent is not null
group by date
order by 1,2

select sum(new_cases) as TotalCase, sum(cast(new_deaths as int)) as TotalDeaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from PortfolioProject..Covid_Deaths
where continent is not null
order by 1,2
--Looking at total Population Vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

-- use cte
with populationVSvaccination(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccinated/population)*100 as percentageRPV
from populationVSvaccination


--Temp Table
select * 
from PortfolioProject..Covid_Deaths
order by 3,4

--select *
--from PortfolioProject..Covid_Vaccinations
--order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject..Covid_Deaths
order by 1,2
select len(location) from PortfolioProject..Covid_Deaths

---selecting total_cases and total_deaths 
---showing the likelihood of dying if you get covid
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from PortfolioProject..Covid_Deaths
where location='India'
order by 1,2

--selecting total cases and population

select location,date,total_cases,population,(total_cases/population)*100 as percentage_contracted
from PortfolioProject..Covid_Deaths
where location='India'
order by 1,2


--selecting countries having highest infection rate compared to population

select location,population,max(total_cases) as highest_infection_count, max(total_cases/population)*100 as highest_percentage_contracted
from PortfolioProject..Covid_Deaths
where continent is not null
group by location,population
order by highest_percentage_contracted desc

--selecting countries with highest death count per population

select location, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is not null
Group by location
order by TotalDeathCount desc
--lets break things down by continent

select location, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is null
Group by location
order by TotalDeathCount desc
--showing the continents with highest death count
select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is not null
Group by continent
order by TotalDeathCount desc

select count(distinct(location))
from PortfolioProject.. Covid_Deaths
where continent like 'Oceania'

--creating views
--Global Numbers
select date,sum(new_cases) as TotalCase, sum(cast(new_deaths as int)) as Totaldeaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as death_percentage
from PortfolioProject..Covid_Deaths
where continent is not null
group by date
order by 1,2

select sum(new_cases) as TotalCase, sum(cast(new_deaths as int)) as TotalDeaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from PortfolioProject..Covid_Deaths
where continent is not null
order by 1,2
--Looking at total Population Vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3

-- use cte
with populationVSvaccination(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(cast(vac.new_vaccinations as bigint)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccinated/population)*100 as percentageRPV
from populationVSvaccination


--Temp Table
drop table if exists #percentpopulationvaccinated
create table #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #percentpopulationvaccinated
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(bigint,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
select *, (RollingPeopleVaccinated/population)*100 as percentRPV
from #percentpopulationvaccinated

---creating a view to store data for later visualization
drop view if exists percentpopvac
create view percentpopvac as 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(CONVERT(bigint,vac.new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

---creating a view to store data for later visualization

drop view if exists summary
create view summary as 
select date,sum(new_cases) as TotalCase, sum(cast(new_deaths as int)) as Totaldeaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as death_percentage
from PortfolioProject..Covid_Deaths
where continent is not null
group by date


---creating a view to store data for later visualization

drop view if exists RPV
create view RPV as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(convert(int,new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null


---create view to store data for later visualization
drop view if exists ContinentVsTotalDeathCount
create view ContinentVsTotalDeathCount as
select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..Covid_Deaths
where continent is not null
Group by continent

--create view to store data for later visualization
create view popVsvac as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
 sum(convert(int,new_vaccinations)) over(partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

