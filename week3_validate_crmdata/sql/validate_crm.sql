TASK2 using regular expressions 

SELECT * FROM staging.crm
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+');


--Combine all three conditions
SELECT * FROM staging.crm
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR 
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive');



CREATE SCHEMA IF NOT EXISTS constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_old(
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK(email LIKE '%@&.%'),
    region VARCHAR CHECK(region IN ('EU', 'US')),
    status VARCHAR CHECK(status IN ('active, inactive'))
);


CREATE TABLE IF NOT EXISTS constrained.crm_new(
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK(regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')),
    region VARCHAR CHECK(region IN ('EU', 'US')),
    status VARCHAR CHECK(status IN ('active, inactive'))
);


INSERT INTO constrained.crm_old 
SELECT *
FROM staging.crm2
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') AND
    region IN ('EU', 'US') AND
    status IN ('active', 'inactive');



INSERT INTO constrained.com_old 
SELECT *
FROM staging.crm
WHERE regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') AND
    region IN ('EU', 'US') AND
    status IN ('active', 'inactive');



    SELECT customer_id
FROM staging.crm2
EXCEPT
SELECT customer_id
FROM staging.crm

--7 common customers
SELECT customer_id
FROM staging.crm
EXCEPT
SELECT customer_id
FROM staging.crm2

--6 common customers
SELECT customer_id
FROM staging.crm2
INTERSECT 
SELECT customer_id
FROM staging.crm


--subquery 1: customers only in the old crm sysytem 

FROM staging.crm2
EXCEPT
SELECT * customer_id
FROM staging.crm

UNION

--subquery 2: customers only in the new crm sysytem 

FROM staging.crm
EXCEPT
SELECT * customer_id
FROM staging.crm2
UNION

--subquery 3: customers violating constraints in old crm system
(SELECT * FROM staging.crm
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'))
UNION

--subquery 4: customers violating constraints in new crm system
(SELECT * FROM staging.crm2
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR 
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive'));

