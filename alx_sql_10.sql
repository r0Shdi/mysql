CREATE VIEW combined_analysis_table 
AS
SELECT province_name, town_name, type_of_water_source AS source_type, location_type, number_of_people_served AS people_served,  time_in_queue, well_pollution.results
FROM md_water_services.location
JOIN visits
ON visits.location_id = location.location_id
JOIN water_source
ON water_source.source_id = visits.source_id 
LEFT JOIN  well_pollution
ON  well_pollution.source_id = water_source.source_id
where visits.visit_count = 1;








SELECT * FROM md_water_services.combined_analysis_table;





WITH province_totals AS (-- This CTE calculates the population of each province 
SELECT
        province_name,
SUM(people_served) AS total_ppl_serv FROM
        combined_analysis_table
GROUP BY
        province_name
)
SELECT
ct.province_name,
-- These case statements create columns for each type of source. -- The results are aggregated and percentages are calculated 
SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv AS river, 
SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv AS shared_tap, 
SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv AS tap_in_home, 
SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv AS tap_in_home_broken, 
SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv AS well
FROM
    combined_analysis_table ct
JOIN
province_totals pt ON ct.province_name = pt.province_name
GROUP BY
    ct.province_name
ORDER BY
    ct.province_name;












WITH town_totals AS (
SELECT province_name , town_name, SUM( people_served ) AS total_ppl_serv
FROM  combined_analysis_table
GROUP BY  province_name ,  town_name
)




SELECT tt.province_name, 
       tt.town_name,
      ROUND( SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END ) * 100/total_ppl_serv) AS river,
	  ROUND( SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END ) * 100/total_ppl_serv) AS shared_tap,
	  ROUND( SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END ) * 100/total_ppl_serv) AS tap_in_home,
	  ROUND( SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END ) * 100/total_ppl_serv) AS tap_in_home_broken,
      ROUND( SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END ) * 100/total_ppl_serv) AS well
      
FROM combined_analysis_table ct
JOIN town_totals tt
ON tt.province_name = ct.province_name AND tt.town_name = ct.town_name
GROUP BY province_name ,  town_name;



















CREATE TABLE Project_progress (
Project_id SERIAL PRIMARY KEY,
source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE, Address VARCHAR(50),
Town VARCHAR(30),
Province VARCHAR(30),
Source_type VARCHAR(50),
Improvement VARCHAR(50),
Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
Date_of_completion DATE,
Comments TEXT
);


SELECT * FROM md_water_services.Project_progress;





INSERT INTO  Project_progress( source_id, Address, Town, Province, Source_type, Improvement)
SELECT
    water_source.source_id,
    location.address,
    location.town_name,
    location.province_name,
    water_source.type_of_water_source,
    CASE WHEN results =  'Contaminated: Biological' THEN 'Install UV filter'
         WHEN results = 'Contaminated: Chemical'    THEN 'Install RO filter'
         WHEN type_of_water_source = 'river'        THEN 'Drill well '
         WHEN type_of_water_source = 'shared_tap'  THEN CONCAT("Install ", FLOOR(time_in_queue / 30), " taps nearby")
         WHEN type_of_water_source = 'tap_in_home_broken' THEN ' Diagnose local infrastructure'
         ELSE NULL END  AS Improvement 
FROM
    water_source
LEFT JOIN
well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN
visits ON water_source.source_id = visits.source_id
INNER JOIN
location ON location.location_id = visits.location_id
WHERE
visits.visit_count = 1 
AND ( 
results != 'Clean'
OR type_of_water_source IN ('tap_in_home_broken','river') 
OR (type_of_water_source = 'shared_tap' AND time_in_queue >=30)
)


































