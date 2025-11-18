/*===========
 Aggregation
 ==========*/

 --create the new table
 
 
 --count distinct department
 SELECT COUNT(DISTINCT department)
FROM staging.more_employees;

--analyze salary
SELECT 
    department,
    ROUND(AVG(monthly_slary_sek)) AS average_salary_sek
    ROUND(MEDIAN(monthly_slary_sek)) AS median_salary_sek
    ROUND(MIN(monthly_slary_sek)) AS minimum_salary_sek
    ROUND(MAX(monthly_slary_sek)) AS maximum_salary_sek
FROM staging.more_employees
GROUP BY department;
