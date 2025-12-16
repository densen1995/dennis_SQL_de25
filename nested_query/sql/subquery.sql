-- filter students with higher score than average 
SELECT * FROM staging.students
WHERE grade_math > (SELECT avg(grade_math) FROM staging.students ) 
ORDER BY grade_math;



--subquery that returns multiple rows 
--used with  in opertaor to check membership 
--filter students in classes taught by Anna s.

SELECT *
FROM 
    staging.students
WHERE 
    class_name IN (
        SELECT 
            class_name
        FROM staging.teachers 
        WHERE 
            teachers_name= 'ANNE S.'
    );
    --in this subquery we used subquery in the teacher table to filter out the students table 



     --Correlated subquery
     -- subquery depends on columns values of outer query
     -- filter students with math grade higher than avg of their own classes 

     SELECT * 
     FROM staging.students S
     WHERE 
        s.grade_math > (
            SELECT avg(grade_math)
            FROM staging.students
            WHERE class_name=s.class_name --(--the filter in the subquery only works when the class_name in the subquery = to the one in the outer query)
        )
        ORDER by s.class_name;

        -- check the result above by looking at average grade per class
        SELECT class_name, avg(grade_math ) as class_avg_grade
        FROM staging.students
        GROUP BY class_name;



        --connect python 
        --uv init 
        -- uv add pandas duckdb ipykernel 

        --when you open the notebook
        -- import duckdb 
        --with duckdb.connect ("file path") as conn:
        --conn.sql("""
        --CREATE TABLE IF NOT EXISTS booking(......
        --)
        --""")


        --to read a csv file directly via python 
        --variable_name=duckdb.sql("""
        --FROM 'filepath';
        --""").df()
        --variable_name
        --variable_name.column or table name()


        --read several csv files and combine 
        bookings= duckdb.sql("""
        FROM 'file path*.csv';:

        """).df()
        bookingd.head()


        --read json data
        duckdb.sql("FROM 'path.json';").df()



        --unnesting





        --use cross join 
