select *
from PortfolioProject..covideaths
order by 3,4

--select *
--from PortfolioProject..covidvaccination
--order by 3,4

--select Data that we are going to be using

select location,date,total_cases_per_million,new_cases_per_million,total_deaths_per_million,population
from PortfolioProject..covideaths
order by 1,2

--Looking at total_cases_per_million vs total_deaths_per_million

select location,date,total_cases_per_million,total_deaths_per_million,(total_deaths_per_million/total_cases_per_million)*100 as DeathPercentage
from PortfolioProject..covideaths
where location like '%ric%'
order by 1,2

--Looking at total_cases_per_million vs population
--shows what percentage of population got covid

select location,date,population,total_cases_per_million,(total_cases_per_million/population)*100 as PercentPopulationInfected
from PortfolioProject..covideaths
--where location like '%ric%'
order by 1,2

--Looking at Countries with Highest Infection Rate compared to Population
select location,population,max(total_cases_per_million) as HighestInfectioncount,max((total_cases_per_million/population))*100 as PercentPopulationInfected 
from PortfolioProject..covideaths
--where location like '%ric%'
group by location,population
order by PercentPopulationInfected desc



select location,max(cast(total_deaths_per_million as int))as total_death_count_per_million 
from PortfolioProject..covideaths
--where location like '%ric%'
group by location
order by total_death_count_per_million desc

--GLOBAL NUMBERS

Select date,SUM(new_cases_smoothed) as total_caese,sum(cast(new_deaths_smoothed as int)) as total_deaths,sum(cast(new_deaths_smoothed as int))/SUM(new_cases_smoothed)*100 as Deathpercentage
from PortfolioProject..covideaths
--where location like '%ric%'
where continent is not null
group by date
order by 1,2

Select SUM(new_cases_smoothed) as total_caese,sum(cast(new_deaths_smoothed as int)) as total_deaths,sum(cast(new_deaths_smoothed as int))/SUM(new_cases_smoothed)*100 as Deathpercentage
from PortfolioProject..covideaths
--where location like '%ric%'
where continent is not null
--group by date
order by 1,2


--LOOKING at Total Population VS Vaccination

--select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--from PortfolioProject..covideaths dea
--join PortfolioProject..covidvaccination vac
--on dea.location = vac.location
--and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3


select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int))over (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/dea.population)*100
from PortfolioProject..covideaths dea
join PortfolioProject..covidvaccination vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null 
order by 2,3




