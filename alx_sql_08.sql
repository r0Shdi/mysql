DROP TABLE IF EXISTS Basic_Services ;
DROP TABLE IF EXISTS  Economic_Indicators;
DROP TABLE IF EXISTS  Geographic_Location;

SELECT * FROM united_nations.Access_to_Basic_Services;




CREATE TABLE Geographic_Location 
             (Country_name VARCHAR(50) PRIMARY KEY,
             Sub_region VARCHAR(50), 
             Region VARCHAR(50), 
             Land_area DECIMAL(10,2));

INSERT INTO Geographic_Location (Country_name, Sub_region, Region, Land_area)
(SELECT Country_name, Sub_region, Region, AVG(Land_area)
FROM  Access_to_Basic_Services
GROUP BY Country_name,
         Sub_region,
         Region  );
   
         
CREATE TABLE Basic_Services ( Country_name  VARCHAR(50),
                              Time_period INT,
                              Pct_managed_drinking_water_services DECIMAL(5,2),
                              Pct_managed_sanitation_services DECIMAL(5,2),
                              PRIMARY KEY(Country_name, Time_period),
                              FOREIGN KEY(Country_name) REFERENCES Geographic_Location(Country_name) );
                              
                              
                              
INSERT INTO Basic_Services (Country_name , Time_period, Pct_managed_drinking_water_services, Pct_managed_sanitation_services)
(SELECT Country_name , Time_period, Pct_managed_drinking_water_services, Pct_managed_sanitation_services 
FROM Access_to_Basic_Services);
                              
                              
CREATE TABLE Economic_Indicators(Country_name VARCHAR(50),
								 Time_period INT, 
                                 Est_gdp_in_billions DECIMAL(8,2),
                                 Est_population_in_millions DECIMAL(11,6), 
                                 Pct_unemployment DECIMAL(4,2),
                                 PRIMARY KEY(Country_name, Time_period),
                                 FOREIGN KEY(Country_name) REFERENCES Geographic_Location(Country_name));






INSERT INTO  Economic_Indicators(Country_name, Time_period, Est_gdp_in_billions, Est_population_in_millions, Pct_unemployment)
(SELECT Country_name, Time_period, Est_gdp_in_billions, Est_population_in_millions, Pct_unemployment
FROM Access_to_Basic_Services);









   
             
             