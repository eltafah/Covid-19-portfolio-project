
SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4;

SELECT * 
--FROM PortfolioProject..CovidVaccinations
--order by 3,4 
--select Data that we are going to be using--
 SELECT Location,date,total_cases,new_cases,total_deaths,population 
 From PortfolioProject..CovidDeaths
 order by 1,2;

--looking at total cases vs total deaths--
--show likeliness of dying if you contracted covid in kenya--

SELECT Location, date, total_cases, total_deaths, (CAST(total_deaths AS float) / CAST(total_cases AS float)) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
where location like '%kenya%'
ORDER BY Location, date;

--looking at total cases vs population--
--shows what percentage of population got covid--
SELECT Location, date, population, total_cases, (CAST(total_cases AS float) / CAST(population AS float)) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
ORDER BY Location, date;


-- Query to determine countries with the highest death toll
SELECT Location, total_deaths
FROM PortfolioProject..CovidDeaths
ORDER BY total_deaths DESC;

-- Query to identify countries with the highest death rate per population
SELECT Location, population, total_deaths, (total_deaths / population) * 100000 AS DeathRatePer100k
FROM PortfolioProject..CovidDeaths
ORDER BY DeathRatePer100k DESC;

-- Query to calculate the daily increase in deaths
SELECT date, total_deaths,
       CAST(total_deaths AS float) - CAST(LAG(total_deaths, 1, 0) OVER (ORDER BY date) AS float) AS daily_death_increase
FROM PortfolioProject..CovidDeaths
ORDER BY date;

-- Query to identify peak death rate periods
WITH DeathRateCTE AS (
    SELECT date, (CONVERT(float, total_deaths) / CONVERT(float, total_cases)) * 100 AS death_rate
    FROM PortfolioProject..CovidDeaths
    WHERE Location = 'Kenya' -- Highlighting Kenya
)
SELECT date, death_rate
FROM DeathRateCTE
WHERE death_rate = (SELECT MAX(death_rate) FROM DeathRateCTE)
ORDER BY date;















 


