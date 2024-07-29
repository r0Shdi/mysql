SELECT * FROM united_nations.Access_to_Basic_Services;

SELECT Region,
       sub_region,
       MIN(Pct_managed_drinking_water_services) AS 'MIN_Pct_managed_drinking_water_services',
       MAX(Pct_managed_drinking_water_services) AS 'MAX_Pct_managed_drinking_water_services',
       AVG(Pct_managed_drinking_water_services) AS 'average_Pct_managed_drinking_water_services',
       COUNT(DISTINCT Country_name) AS 'total_number_of_countries',
       ROUND(SUM(Est_gdp_in_billions),0) AS 'total_gdb_of_the_region'
FROM united_nations.Access_to_Basic_Services
GROUP BY 
        Region,
        sub_region
ORDER BY total_gdb_of_the_region ASC;

-- this query will produce an error
SELECT Region,
       sub_region,
       MIN(Pct_managed_sanitation_services) AS 'MIN_Pct_managed_sanitation_services',
       MAX(Pct_managed_sanitation_services) AS 'MAX_Pct_managed_sanitation_services',
       AVG(Pct_managed_sanitation_services) AS 'average_Pct_managed_sanitation_services',
       COUNT(DISTINCT Country_name) AS 'total_number_of_countries',
       ROUND(SUM(Est_gdp_in_billions),0) AS 'total_gdb_of_the_region'
FROM united_nations.Access_to_Basic_Services;

-- returns no error after removing the columns
SELECT 
       MIN(Pct_managed_sanitation_services) AS 'MIN_Pct_managed_sanitation_services',
       MAX(Pct_managed_sanitation_services) AS 'MAX_Pct_managed_sanitation_services',
       AVG(Pct_managed_sanitation_services) AS 'average_Pct_managed_sanitation_services',
       COUNT(DISTINCT Country_name) AS 'total_number_of_countries',
       ROUND(SUM(Est_gdp_in_billions),0) AS 'total_gdb_of_the_region'
FROM united_nations.Access_to_Basic_Services;



