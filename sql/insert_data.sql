INSERT INTO countries (iso_code, continent, location, population, population_density, median_age, aged_65_older, aged_70_older)
SELECT DISTINCT iso_code, continent, location, population, population_density, median_age, aged_65_older, aged_70_older
FROM staging_data;

INSERT INTO covid_cases (country_id, date, total_cases, new_cases, total_deaths, new_deaths)
SELECT c.country_id, s.date, s.total_cases, s.new_cases, s.total_deaths, s.new_deaths
FROM staging_data s
JOIN countries c ON s.iso_code = c.iso_code;

INSERT INTO vaccinations (country_id, date, total_vaccinations, people_vaccinated, people_fully_vaccinated, total_boosters)
SELECT c.country_id, s.date, s.total_vaccinations, s.people_vaccinated, s.people_fully_vaccinated, s.total_boosters
FROM staging_data s
JOIN countries c ON s.iso_code = c.iso_code;

INSERT INTO policies (country_id, date, stringency_index)
SELECT c.country_id, s.date, s.stringency_index
FROM staging_data s
JOIN countries c ON s.iso_code = c.iso_code;
