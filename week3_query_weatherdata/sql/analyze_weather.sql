/*========
    TASK2
   ========= */
   DESC staging.weather;



   DESC
   SELECT
        sunriseTime,
        sunsetTime,
        temperatureHighTime,
        temperatureLowTime,
        windGustTime,
        precipIntensityMaxTime
   FROM staging.weather; 

   /*======
    Task3
    =======*/

    --each row in the dataset contains weather data for each combination of country/region, province/state and date(time column)
    -- its important to understand which columns can be used to uniquely identify each row
    -- use aggregation function together with group by

SELECT
  "Country/Region" AS Country,
  "Province/State" AS State,
 COUNT(*) AS Nr_Records,
FROM staging.weather
GROUP BY "Country/Region", "Province/State";

/*==========
    task4
  ========*/  
SELECT
  to_timestamp(sunriseTime) AS sunrise_utc,
  to_timestamp(sunriseTime) AT TIME ZONE 'Europe/Stockholm' AS sunrisesw_time,
  to_timestamp(sunsetTime) AS sunset_utc,
  to_timestamp(sunsetTime) AT TIME ZONE 'Europe/Stockholm' AS sunsetsw_time,
FROM staging.weather
WHERE "Country/Region" = 'Sweden';



/*========
    task5
  ========*/


  SELECT 
 SELECT 
  date_part('year', to_timestamp(sunriseTime)) AS year,
  date_part('month', to_timestamp(sunriseTime)) AS month,
  MAX(to_timestamp(sunriseTime)) AS sunrise_largest_gap_date, -- MAX() will pick up the first row
  MAX(to_timestamp(sunsetTime)) AS sunset_largest_gap_date, -- MAX() will pick up the first row
  MAX(ROUND((sunsetTime-sunriseTime)/3600)) AS gap_hours,
FROM staging.weather
WHERE "Country/Region" = 'Sweden'
GROUP BY year, month
ORDER BY year, month, gap_hours DESC; -- make sure the date with the largest gap is always the first row for each year-month

/* ========

/*========
 task 6
 ========*/

   SELECT 
    to_timestamp(windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
    date_part('hour', most_windy_timestamp) AS most_windy_hour,
    CONCAT('It''s dangerous to use the create at kl.', most_windy_hour)
    FROM staging.weather
    WHERE "Country/Region" = 'Sweden'

    SELECT 
    to_timestamp(windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
    --date_part('hour', most_windy_timestamp) AS most_windy_hour,
    strftime(most_windy_timestamp, '%H' ) AS most_windy_hour,
    CONCAT('It''s dangerous to use the create at kl.', most_windy_hour)
    FROM staging.weather
    WHERE "Country/Region" = 'Sweden'
    