-- Top 10 Countries by total cases 
SELECT c.country_name, MAX(cc.total_cases) AS total_cases
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_cases DESC
LIMIT 10;

-- TOp 10 Countries by total deaths
SELECT c.country_name, MAX(cc.total_deaths) AS total_deaths
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_deaths DESC
LIMIT 10;

-- Global daily cases vs deaths 
SELECT date,
       SUM(new_cases) AS global_new_cases,
       SUM(new_deaths) AS global_new_deaths
FROM covid_cases
GROUP BY date
ORDER BY date;

-- Stringency policies vs cases 
SELECT cc.date, p.stringency_index, cc.new_cases
FROM covid_cases cc
JOIN policies p ON cc.country_id = p.country_id AND cc.date = p.date
JOIN countries c ON cc.country_id = c.country_id
WHERE c.country_name = 'United States'
ORDER BY cc.date;

-- Continental impact (Total cases by Continent)
SELECT c.continent, SUM(cc.total_cases) AS total_cases
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.continent
ORDER BY total_cases DESC;

-- Vaccination Progress by country (% of population fully vaccinated)
SELECT c.country_name,
       ROUND(MAX(v.people_fully_vaccinated) * 100.0 / c.population, 2) AS fully_vaccinated_percent
FROM vaccinations v
JOIN countries c ON v.country_id = c.country_id
WHERE c.population > 1000000
GROUP BY c.country_name
ORDER BY fully_vaccinated_percent DESC
LIMIT 10;

-- Continent-wise Total cases
SELECT c.continent, SUM(cc.total_cases) AS total_cases
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.continent
ORDER BY total_cases DESC;

-- Boosters Shots Leaders 
SELECT c.country_name, MAX(v.total_boosters) AS boosters_given
FROM vaccinations v
JOIN countries c ON v.country_id = c.country_id
GROUP BY c.country_name
ORDER BY boosters_given DESC
LIMIT 10;

-- Deaths per million Population
SELECT c.country_name,
       ROUND(MAX(cc.total_deaths) * 1000000.0 / c.population, 2) AS deaths_per_million
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
WHERE c.population > 1000000
GROUP BY c.country_name
ORDER BY deaths_per_million DESC
LIMIT 10;

-- year-wise cases and deaths
SELECT 
    c.location,
    STRFTIME('%Y', cc.date) AS year,
    SUM(cc.new_cases) AS total_cases_year,
    SUM(cc.new_deaths) AS total_deaths_year
FROM covid_cases cc
JOIN countries c 
    ON cc.country_id = c.country_id
GROUP BY c.location, year
ORDER BY c.location, year;

-- vacinations vs cases(correlation check)
SELECT 
    c.country_name,
    MAX(v.people_fully_vaccinated) * 100.0 / c.population AS fully_vaccinated_percent,
    MAX(cc.total_cases) * 1000000.0 / c.population AS cases_per_million
FROM vaccinations v
JOIN covid_cases cc ON v.country_id = cc.country_id AND v.date = cc.date
JOIN countries c ON c.country_id = v.country_id
WHERE c.population > 5000000
GROUP BY c.country_name
ORDER BY fully_vaccinated_percent DESC;

-- death by age factor
SELECT 
    c.country_name,
    c.median_age,
    c.aged_65_older,
    MAX(cc.total_deaths) * 1000000.0 / c.population AS deaths_per_million
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY deaths_per_million DESC
LIMIT 10;
