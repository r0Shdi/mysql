SELECT  Country_name, 
        Time_period, 
        Est_gdp_in_billions,
        round(Est_gdp_in_billions, 0) AS 'rounded_Est_gdp_in_billions',
        log(Est_gdp_in_billions) AS 'log_Est_gdp_in_billions',
        sqrt(Est_gdp_in_billions) AS 'sqrt_Est_gdp_in_billions'
FROM united_nations.Access_to_Basic_Services;



