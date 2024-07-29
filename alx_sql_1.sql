SELECT * FROM united_nations.Access_to_Basic_Services;
CREATE TABLE Access_to_Basic_Services(Region VARCHAR(32), 
             Sub_region VARCHAR(25), 
             Country_name VARCHAR(45) NOT NULL, 
             Time_period INTEGER NOT NULL, 
             pct_manged_drinking_water_services NUMERIC(5,2), 
             pct_manged_sanitation_services NUMERIC(5,2), 
             Est_population_in_milions NUMERIC(11,2), 
             Est_gdb_in_billions NUMERIC(8,2), 
             Land_area NUMERIC(10,2), 
             Pct_unemployment NUMERIC(5,2));
             


SELECT * FROM  Access_to_Basic_Services;



UPDATE Access_to_Basic_Services
SET Pct_unemployment= 4.53
WHERE Country_name='China' AND Time_period ='2016';

DROP DATABASE united_nations;

