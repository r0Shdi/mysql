SELECT  visits.source_id, time_in_queue, type_of_water_source, number_of_people_served
FROM visits
INNER JOIN water_source 
ON visits.source_id = water_source.source_id
WHERE visits.source_id ="AkLu01628224"
;





SELECT distinct type_of_water_source from water_source;


SELECT * FROM water_quality
INNER JOIN visits
ON visits.record_id = water_quality.record_id
INNER JOIN  water_source
ON water_source.source_id = visits.source_id
WHERE subjective_quality_score=10 AND type_of_water_source ='tap_in_home' AND visits.visit_count >=2  ;


SELECT * FROM well_pollution
WHERE  results= 'Clean' AND biological >0.01
ORDER BY biological DESC;


SELECT * FROM well_pollution
WHERE  description LIKE  'Clean_%' AND biological >0.01
ORDER BY biological DESC;




CREATE TABLE well_pollution_copy 
AS (SELECT * FROM well_pollution);



SELECT * FROM well_pollution
WHERE  description LIKE  'Clean_%' AND biological >0.01
ORDER BY biological DESC;




UPDATE well_pollution
SET description= 'Bacteria: E. coli' 
WHERE description= 'Clean Bacteria: E. coli' AND biological >0.01 ;

UPDATE well_pollution
SET description= 'Bacteria: Giardia Lamblia' 
WHERE description= 'Clean Bacteria: Giardia Lamblia' AND biological >0.01;

UPDATE well_pollution
SET results ='Contaminated: Biological' 
WHERE results= 'Clean' AND biological >0.01 ;










