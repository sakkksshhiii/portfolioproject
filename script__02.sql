-- create database portfolioproject;
use portfolioproject;
-- select * from portfolioproject.covid_vaccines;
-- select * from portfolioproject.covid_deaths
-- order by 3,4
 
--  select data that we are going to be using

-- select location,date, total_cases,new_cases,total_deaths,population_density 
-- from covid_deaths
-- order by 1,2;

-- looking at total cases vs total deaths

-- select location,date, total_cases,total_deaths,(total_cases/total_deaths) * 100 as deathpercentage
-- from covid_deaths
-- where location like "%afghanistan%"
-- order by 1,2;

-- looking at total cases vs population
-- shows what percentage of population got covid

 -- select location,date, total_cases,population_density,(total_cases/population_density)  as percentpopulationinfected
-- from covid_deaths
-- where location like "%afghanistan%"
-- order by 1,2;

-- looking at countries with highest infection rate compared to population

-- select location,max(total_cases) as highestinfectioncount,population_density,max(total_cases/population_density)  as percentpopulationinfected
-- from covid_deaths
-- where location like "%afghanistan%"
-- group by location, population_density
-- order by percentpopulationinfected desc;

-- showing countries with highest death count per population 

-- select location , max(total_deaths) as totaldeathcount
-- from covid_deaths
-- where location like "%afghanistan%"
-- group by location
-- order by totaldeathcount desc;

-- let's break things down by continent
-- showing continent with the highest death count per population

-- select continent , max(total_deaths) as totaldeathcount
-- from covid_deaths
-- -- where location like "%afghanistan%"
-- where continent is not null
-- group by location
-- order by totaldeathcount desc; 

-- global numbers

-- select date,sum(new_cases) ,sum(new_deaths),sum(new_deaths)/sum(new_cases) * 100 as deathpercentage
-- from covid_deaths
-- where continent is not null
-- group by date
-- order by 1,2;

-- select sum(new_cases) ,sum(new_deaths),sum(new_deaths)/sum(new_cases) * 100 as deathpercentage
-- from covid_deaths
-- where continent is not null
-- -- group by date
-- order by 1,2;

-- looking at total vaccination vs population

-- select * from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date

-- select dea.continent, dea.location, dea.date, dea.population_density,vac.new_vaccinations, sum(vac.new_vaccinations) over( partition by dea.location order by dea.location,dea.date) 
-- as rollingpeoplevaccinated
--  from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date
-- where dea.continent is not null
-- order by 2,3

-- use CTE

-- with popvsvac ( continent, date,location, population_density, new_vaccination,rollingpeoplevaccinated)
-- as
-- (
-- select dea.continent, dea.location, dea.date, dea.population_density,vac.new_vaccinations, sum(vac.new_vaccinations) over( partition by dea.location order by dea.location,dea.date) 
-- as rollingpeoplevaccinated
--  from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date
-- where dea.continent is not null
-- -- order by 2,3
-- )
-- select dea.continent, dea.location, dea.date, dea.population_density,vac.new_vaccinations, sum(vac.new_vaccinations) over( partition by dea.location order by dea.location,dea.date) 
-- as rollingpeoplevaccinated
--  from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date
-- where dea.continent is not null
-- -- order by 2,3
-- select (rollingpeoplevaccinated/ population_density) * 100 from popvsvac
 
-- temp table

-- drop table if exists percentpopulationvaccinated;
-- create temporary table percentpopulationvaccinated
-- (
-- continent varchar(255),
-- location varchar(255),
-- date datetime,
-- popution_density numeric,
-- new_vaccinations numeric,
-- rollingpeoplevaccinated numeric)

-- insert into percentpopulationvaccinated values
-- select dea.continent, dea.location, dea.date, dea.population_density,vac.new_vaccinations,
-- sum(vac.new_vaccinations) over( partition by dea.location order by dea.location,dea.date) 
-- as rollingpeoplevaccinated
-- from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date
-- where dea.continent is not null
-- -- order by 2,3

-- -- select (rollingpeoplevaccinated/ population_density) * 100 from percentpopulationvaccinated
--  


-- creating view to store data for later visualization

-- create view percentpopulationvaccinated as
-- select dea.continent, dea.location, dea.date, dea.population_density,vac.new_vaccinations,
-- sum(vac.new_vaccinations) over( partition by dea.location order by dea.location,dea.date) 
-- as rollingpeoplevaccinated
-- from portfolioproject.covid_deaths as dea
-- join portfolioproject.covid_vaccines as vac
-- on dea.location= vac.location
-- and dea.date= vac.date
-- where dea.continent is not null

select * from percentpopulationvaccinated
 