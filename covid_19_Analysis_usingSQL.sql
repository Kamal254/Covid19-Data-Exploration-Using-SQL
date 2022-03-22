
-- Total cases and total deaths by location
select Location,date, total_cases, total_deaths
from covid_deaths_data
order by 1;

-- Looking at total cases vs total Deaths 
select Location, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_precentage
from covid_deaths_data
order by 1;

-- Show lielihood of dying of you contract covid in your country
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_precentage
from covid_deaths_data
where Location like '%ia'
order by 1,2;

-- Lookign at total cases and death vs population
-- shows what % of population got covid and died
select Location, date, Population,  total_cases, total_deaths, (total_cases/Population)*100 as population_vs_cases,(total_deaths/Population)*100 as population_vs_death
from covid_deaths_data
order by 1,2;

-- Looking at countries with Highest Infection Rate compare to population
select Location, Population, max(total_cases) as HighestInfectionRate, max((total_cases/Population)*100) as PercentPopulationInfected
from covid_data
group by Location , Population, total_deaths
order by PercentPopulationInfected desc;

-- Let's Break Things down by CONTINENT

-- Showing Countries with Highest Death Count per Population

select Location, Population, max(total_deaths) as TotalDeath
from covid_deaths_data
where Continent is not null
group by Location
order by TotalDeath desc;

-- Showing continents with the highest death count per population

select Location, Population, max(total_deaths) as TotalDeath
from covid_deaths_data
where Continent is not null
group by Continent
order by TotalDeath desc;

-- Gobal Numbers
select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from covid_data
group by date
order by 1;

-- rate of percentage increasing cases per day
select date ,location, new_cases,total_cases, (new_cases/total_cases)*100 percent_increament
from covid_data
order by date;




-- Lets Join our Covid_death table and covid_vaccinations table on location and create a new table
create table death_vaccination as
select  death.continent, death.location, death.date, death.Population, vacc.new_vaccinations, vacc.total_vaccinations, vacc.people_vaccinated , vacc.people_fully_vaccinated from covid_data death
join covid_vaccinations vacc
on death.Location = vacc.Location;

-- Looking at Total Population vs Vaccinations
select * from death_vaccination;
select count(*) from death_vaccination;-- we have 468720 Rows

-- Looking at Total Population vs Vaccinations

 select continent, Location, date,new_vaccinations, sum(convert(int, new_vaccinations)) over (partition by Location order by Location) as Peaople_vaccinated 
 from death_vaccination
 where total_vaccinations != 0
 order by 1,3;










