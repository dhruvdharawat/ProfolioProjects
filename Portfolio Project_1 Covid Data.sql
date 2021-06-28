select * 
from covid_d

Select * 
from covid_v

select location,date,total_cases,new_cases,total_deaths,population
from covid_d 
order by 1,2


--Looking at Total Cases vs Total Deaths
--This shows the liklihood of dying in your country

select location,date,total_cases,total_deaths,round(((total_deaths/total_cases)*100),2) as Death_Percentage
from covid_d
where location = 'India' and continent is not null
order by 1,2


--Looking at Total_cases vs Population
--Shows what % of Population got Covid

select location,date,total_cases,population,round(((total_deaths/population)*100),2) as Infected_Population
from covid_d
where continent is not null
order by 1,2

--Looking at Countries with Highest Infection rates when compared with Popluation

select location,population,max(total_cases) as HighestInfectioncount,max((total_cases/population)*100) as infected_population
from covid_d
where continent is not null
group by location,population
order by infected_population desc


--Shows Countries with Highest Death Count per Population

select location,max(cast(total_deaths as int)) as TotalDeathCount
from covid_d
where continent is not null
group by location
order by TotalDeathCount desc



--Global numbers

select date,sum(new_cases) as new_cases,sum(cast(new_deaths as int)) as new_Deaths,round(sum(cast(new_deaths as int))/sum(new_cases)*100,2)as Death_Percentage
from covid_d
--where location = 'India' 
 where continent is not null
 group by date
order by 1,2

--Total Population VS Total Vaccinated

select covid_d.continent,covid_d.location,covid_d.date,population,new_vaccinations
from covid_d
join covid_v
on covid_d.location=covid_v.location
and covid_d.date=covid_v.date
where covid_d.continent is not null
order by 1,2,3



