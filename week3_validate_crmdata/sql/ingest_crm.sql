CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.crm AS (
    SELECT * FROM read_csv_auto('data/crm_new.csv')
);

CREATE TABLE IF NOT EXISTS staging.crm2 AS (
    SELECT * FROM read_csv_auto('data/crm_old.csv')
);

CREATE TABLE IF NOT EXISTS staging.crm_all AS(
SELECT * FROM staging.crm 
UNION 
SELECT * FROM staging.crm2
);