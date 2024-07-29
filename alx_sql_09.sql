DROP TABLE IF EXISTS auditor_report; 

CREATE TABLE auditor_report(
location_id VARCHAR(32), type_of_water_source VARCHAR(64), true_water_source_score int DEFAULT NULL, statements VARCHAR(255)
);



SELECT * FROM md_water_services.auditor_report;



WITH 
      auditor_test AS(
                       SELECT auditor_report.location_id AS audit_location, 
					          water_quality.record_id,
					          true_water_source_score AS auditor_score,
                              subjective_quality_score AS surveyor_score
                       FROM md_water_services.auditor_report
                       JOIN visits 
                       ON visits.location_id = auditor_report.location_id
                       JOIN water_quality
                       ON visits.record_id = water_quality.record_id
                       WHERE water_quality.visit_count=1
)


SELECT * 
FROM auditor_test 
WHERE auditor_score != surveyor_score;





CREATE VIEW 
            Incorrect_records AS(
                           SELECT  auditor_report.location_id,
					               visits.record_id,
       			                   true_water_source_score AS auditor_score,
						           subjective_quality_score AS surveyor_score,
	   				               employee.assigned_employee_id,
						           employee_name,
                                   statements
                           FROM visits
                           JOIN auditor_report
                           ON visits.location_id = auditor_report.location_id
                           JOIN water_quality
                           ON visits.record_id =water_quality.record_id
                           JOIN  employee
                           ON   employee.assigned_employee_id = visits.assigned_employee_id
                           WHERE   water_quality.visit_count=1 AND 
                                   true_water_source_score != subjective_quality_score 
);








WITH 
     Incorrect_records AS(
                           SELECT  auditor_report.location_id,
					               visits.record_id,
       			                   true_water_source_score AS auditor_score,
						           subjective_quality_score AS surveyor_score,
	   				               employee.assigned_employee_id,
						           employee_name,
                                   statements
                           FROM visits
                           JOIN auditor_report
                           ON visits.location_id = auditor_report.location_id
                           JOIN water_quality
                           ON visits.record_id =water_quality.record_id
                           JOIN  employee
                           ON   employee.assigned_employee_id = visits.assigned_employee_id
                           WHERE   water_quality.visit_count=1 AND 
                                   true_water_source_score != subjective_quality_score 
),
     error_count AS(
                     SELECT employee_name, Count(employee_name) AS number_of_mistakes
                     FROM Incorrect_records
                     GROUP BY employee_name
),
    avg_error_count_per_empl AS (
                                 SELECT AVG(number_of_mistakes)
                                 FROM error_count
), 
    suspect_list AS(
                     SELECT
                            employee_name,
                            number_of_mistakes
					 FROM error_count
					 WHERE
						  number_of_mistakes > (SELECT * FROM avg_error_count_per_empl)


)


SELECT employee_name, location_id, statements
FROM incorrect_records
WHERE  employee_name IN (SELECT employee_name FROM suspect_list) ;

SELECT employee_name, location_id, statements
FROM incorrect_records
WHERE employee_name NOT IN (SELECT employee_name FROM suspect_list) AND 
      statements LIKE '%cash%';













