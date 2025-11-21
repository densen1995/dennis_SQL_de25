SELECT 
  title,
  context,
  INSTR(title, context) -- no match if there is no match 
FROM staging.squad
WHERE NOT regexp_matches(context, title);


SELECT 
  *
FROM staging.squad

WHERE context LIKE CONCAT(title, '%');
-- check the results for SOuthern_California



SELECT *
FROM staging.squad
WHERE regexp_matches(context,CONCAT('^', title));


/*========
Task4
=======*/

--show a new column which is the first answer from AI model
SELECT
 answers[18:], --slicing
 answers[18], -- indexing
 CASE
   WHEN answers[18] = ',' THEN NULL 
   ELSE answers[18:]
 END AS striped_answers,
 INSTR(striped_answers, '''') AS first_quotation_index,
 striped_answers[:first_quotation_index-1] 
 AS first_answers,
 answers
FROM staging.squad;

SELECT
-- ^ inside the square bracket means retsrict(not )
--and outside means starts with
  regexp_extract(answers, '''([^'']+) '', ') AS first_answer,
  regexp_extract(answers, '''([A-Za-z,0-9 ,]+)'',', 1)AS first_answer1,
  answers
FROM staging.squad;
 
