alter table vaccinations add column date_iso TEXT;
alter table staging_data add column date_iso TEXT;
alter table policies add column date_iso TEXT;
alter table covid_cases add column date_iso text;

-- changing the date format from mm/dd/yyyy to yyyy-mm-dd
UPDATE vaccinations
SET date_iso = 
    SUBSTR(date, LENGTH(date) - 3, 4) || '-' ||                   
    printf('%02d', CAST(SUBSTR(date, 1, INSTR(date, '/') - 1) AS INT)) || '-' ||   
    printf('%02d', CAST(SUBSTR(date, INSTR(date, '/') + 1, (LENGTH(date) - 5) - INSTR(date, '/')) AS INT));

UPDATE staging_data
SET date_iso = 
    SUBSTR(date, LENGTH(date) - 3, 4) || '-' ||                   
    printf('%02d', CAST(SUBSTR(date, 1, INSTR(date, '/') - 1) AS INT)) || '-' ||   
    printf('%02d', CAST(SUBSTR(date, INSTR(date, '/') + 1, (LENGTH(date) - 5) - INSTR(date, '/')) AS INT));
UPDATE policies
SET date_iso = 
    SUBSTR(date, LENGTH(date) - 3, 4) || '-' ||                   
    printf('%02d', CAST(SUBSTR(date, 1, INSTR(date, '/') - 1) AS INT)) || '-' ||   
    printf('%02d', CAST(SUBSTR(date, INSTR(date, '/') + 1, (LENGTH(date) - 5) - INSTR(date, '/')) AS INT));

UPDATE covid_cases
SET date_iso = 
    SUBSTR(date, LENGTH(date) - 3, 4) || '-' ||                   
    printf('%02d', CAST(SUBSTR(date, 1, INSTR(date, '/') - 1) AS INT)) || '-' ||   
    printf('%02d', CAST(SUBSTR(date, INSTR(date, '/') + 1, (LENGTH(date) - 5) - INSTR(date, '/')) AS INT));

-- removing unnecessary column and renaming the column to understandable way
alter table vaccinations drop COLUMN date;
ALTER table vaccinations rename date_iso to date;

alter table staging_data drop column date;
alter table staging_data rename  date_iso to date;

ALTER TABLE policies drop column date;
ALTER TABLE policies rename date_iso to date;

ALTER TABLE covid_cases drop column date;
ALTER TABLE covid_cases rename date_iso to date;

-- renaming the column name
alter table countries rename location to country_name ;
alter table staging_data rename location to country_name;