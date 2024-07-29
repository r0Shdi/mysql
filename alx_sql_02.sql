CREATE TABLE you(Region VARCHAR(45), 
                  Sub_region VARCHAR(45), 
                  Country_name VARCHAR(45), 
                  Time_period INT, 
                  Pct_managed_drinking_water_services NUMERIC(5,2), 
                  Pct_managed_sanitation_services NUMERIC(5,2), 
                  Est_population_in_millions NUMERIC(11,2), 
                  Est_gdp_in_billions NUMERIC(8,2), 
                  Land_area NUMERIC(10,2), 
                  Pct_unemployment NUMERIC(5,2));


INSERT INTO you(Region , 
                  Sub_region , 
                  Country_name , 
                  Time_period , 
                  Pct_managed_drinking_water_services , 
                  Pct_managed_sanitation_services , 
                  Est_population_in_millions, 
                  Est_gdp_in_billions , 
                  Land_area , 
                  Pct_unemployment )
SELECT * FROM united_nations.Access_to_Basic_Services;

SELECT * FROM united_nations.you
LIMIT 4;
DROP TABLE you;






