SELECT * FROM md_water_services.employee;

-- mistake and fix
UPDATE employee 
SET employee_name = CONCAT(REPLACE(employee_name, ' ', '.'), '@ndogowater.gov');

UPDATE employee 
SET employee_name = REPLACE(LEFT(employee_name, position('@' IN employee_name)-1), '.', ' ');

-- 


UPDATE employee 
SET  email= CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov');






-- *******************************************

SELECT LENGTH(phone_number)
FROM
employee;

UPDATE employee
SET phone_number =trim(phone_number);


SELECT town_name, COUNT(*) AS "employees' number"
FROM md_water_services.employee
GROUP BY town_name;

SELECT employee_name, email, phone_number FROM md_water_services.visits
JOIN  employee
ON visits.assigned_employee_id =employee.assigned_employee_id
ORDER BY visit_count DESC
LIMIT 3;




-- *******************************************
SELECT * FROM md_water_services.location;


SELECT COUNT(*) AS records_per_town, town_name
FROM md_water_services.location
GROUP BY town_name
ORDER BY records_per_town DESC;


SELECT COUNT(*) AS records_per_town, province_name
FROM md_water_services.location
GROUP BY province_name
ORDER BY records_per_town DESC;

SELECT province_name, town_name, COUNT(*) AS records_per_town
FROM md_water_services.location
GROUP BY province_name, town_name
ORDER BY province_name, records_per_town DESC;


SELECT COUNT(*) AS records_per_town, location_type
FROM md_water_services.location
GROUP BY location_type
ORDER BY records_per_town DESC;





-- *******************************************




SELECT * FROM md_water_services.water_source;




SELECT SUM(number_of_people_served) AS total_people_served
FROM md_water_services.water_source;


SELECT type_of_water_source, COUNT(*) AS total_number_of_sources
FROM md_water_services.water_source
GROUP BY type_of_water_source;



SELECT type_of_water_source, round(avg(number_of_people_served) ) AS ave_people_per_source
FROM md_water_services.water_source
GROUP BY type_of_water_source;



SELECT type_of_water_source, sum(number_of_people_served)  AS total_population_served_per_source
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY total_population_served_per_source DESC;







SELECT type_of_water_source, round(sum(number_of_people_served)*100/27628140)  AS percentage_served_per_source
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY percentage_served_per_source DESC;




-- *******************************************
SELECT * FROM md_water_services.water_source;


CREATE TABLE new_source_count(type_of_water_source VARCHAR(50), total_population_served_per_source INT );

DROP TABLE new_source_count;

INSERT INTO new_source_count(type_of_water_source , total_population_served_per_source  )
(SELECT type_of_water_source, sum(number_of_people_served)  AS total_population_served_per_source
FROM md_water_services.water_source
GROUP BY type_of_water_source);

SELECT * FROM md_water_services.new_source_count;

DELETE FROM new_source_count
WHERE type_of_water_source = 'tap_in_home';

SELECT type_of_water_source, 
       total_population_served_per_source,
       RANK() OVER( ORDER BY total_population_served_per_source  DESC) as rank_by_population
FROM new_source_count;



SELECT * FROM md_water_services.water_source;


SELECT source_id, 
       type_of_water_source, 
       number_of_people_served,
       DENSE_RANK() OVER( ORDER BY number_of_people_served DESC) AS priority_rank
FROM md_water_services.water_source;






-- *******************************************

SELECT * FROM md_water_services.visits;


SELECT datediff(MAX(time_of_record), MIN(time_of_record)) AS survey_time
FROM md_water_services.visits;




SELECT ROUND(AVG(time_in_queue)) AS avg_queue_time
FROM md_water_services.visits
WHERE time_in_queue >0;

SELECT  round(AVG(NULLIF(time_in_queue, 0)))AS avg_queue_time
FROM md_water_services.visits;

ALTER TABLE visits 
ADD column day_of_the_week VARCHAR(15);

UPDATE visits 
SET day_of_the_week= dayname(time_of_record);

ALTER TABLE visits
drop COLUMN day_of_the_week;

SELECT dayname(time_of_record) as day_of_week , ROUND(AVG(time_in_queue)) AS avg_queue_time_per_day
FROM md_water_services.visits
WHERE time_in_queue >0
GROUP BY dayname(time_of_record);



SELECT time_format(TIME(time_of_record), '%H:00') AS hour_of_day, ROUND(AVG(time_in_queue)) AS avg_queue_time_per_hour
FROM md_water_services.visits
WHERE time_in_queue >0
GROUP BY time_format(TIME(time_of_record), '%H:00')
ORDER BY hour_of_day ASC;










SELECT 
       time_format(TIME(time_of_record), '%H:00') AS hour_of_day, 
       ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Sunday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Sunday,
	 ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Monday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Monday,
	 ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Tuesday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Tuesday,
	ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Wednesday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Wednesday, 
    ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Thursday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Thursday, 
     ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Friday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Friday,                  
     ROUND(AVG(CASE
                      WHEN DAYNAME(time_of_record) = 'Saturday' 
                      THEN time_in_queue
                      ELSE NULL 
                      END)) AS Saturday
       
FROM md_water_services.visits
WHERE time_in_queue >0
GROUP BY  time_format(TIME(time_of_record), '%H:00')
ORDER BY hour_of_day ASC;


















