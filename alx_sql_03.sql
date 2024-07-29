CREATE TABLE country_list (country VARCHAR(45));

INSERT INTO country_list(country)
SELECT DISTINCT Country_name 
FROM united_nations.Access_to_Basic_Services;

SELECT Country_name,Time_period, Pct_managed_drinking_water_services 
FROM united_nations.Access_to_Basic_Services 
WHERE Time_period= 2020
ORDER BY Pct_managed_drinking_water_services ASC 
LIMIT 4 ;






