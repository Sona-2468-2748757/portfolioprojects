select * from project1.`covid deaths`
where continent is not null
order by 3,4;

-- select * from project1.`covid vacsination`
-- order by 3,4;

select location, date, total_cases, new_cases, total_deaths
from project1.`covid deaths`
where continent is not null
order by 1,2;

-- looking at total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from project1.`covid deaths`
where continent is not null
-- where location like '%states%'
order by 1,2;


-- looking at countries with highest infection rate 

select location, date, max(total_deaths) as highestinfectioncount, max(total_deaths/total_cases)*100 as presentpopulationinfected
from project1.`covid deaths`
where continent is not null
group by location , date
-- where location like '%states%'
order by presentpopulationinfected desc;

-- showing countries with highest death count 

select location,  max(cast(total_deaths as float )) as totaldeathcount
from project1.`covid deaths`
-- where location like '%states%'
where continent is not null
group by location 
order by totaldeathcount desc;


select location,  max(cast(total_deaths as float )) as totaldeathcount
from project1.`covid deaths`
-- where location like '%states%'
where continent is  null
group by location 
order by totaldeathcount desc;

-- global numbers

select  sum(new_cases) as total_cases,sum(cast(new_deaths as float )) as total_deaths ,sum(cast(new_deaths as float))/sum(new_cases)*100 as deathpercentage
from project1.`covid deaths`
where continent is not null
-- where location like '%states%'
group by date
order by 1,2;

-- looking at total population vs caccination

select dea.continent,dea.location,dea.date as rollingpeoplevaccinated
-- (rollingpeoplevaccinated/population)*100
from project1.`covid deaths` dea
join project1.`covid vacsination` vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3;

-- use CTE

with popvsvac (continent,location ,rollingpeoplevaccinated)
as
(
select dea.continent,dea.location,dea.date as rollingpeoplevaccinated
-- (rollingpeoplevaccinated/population)*100
from project1.`covid deaths` dea
join project1.`covid vacsination` vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3
)
select * , (rollingpeoplevaccinated) * 100
from popvsvac




