CREATE TABLE countries (
    country_id INTEGER PRIMARY KEY AUTOINCREMENT,
    iso_code TEXT UNIQUE,
    continent TEXT,
    location TEXT,
    population INTEGER,
    population_density REAL,
    median_age REAL,
    aged_65_older REAL,
    aged_70_older REAL
);

CREATE TABLE covid_cases (
    case_id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id INTEGER,
    date DATE,
    total_cases INTEGER,
    new_cases INTEGER,
    total_deaths INTEGER,
    new_deaths INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE vaccinations (
    vac_id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id INTEGER,
    date DATE,
    total_vaccinations INTEGER,
    people_vaccinated INTEGER,
    people_fully_vaccinated INTEGER,
    total_boosters INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id INTEGER,
    date DATE,
    stringency_index REAL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

