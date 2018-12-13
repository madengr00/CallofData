-- Create and use games_db
-- create database games_db;
USE games_db;

SELECT clean_igdb_df.name, 
		clean_igdb_df.esrb,
        vgsales.rank,
        vgsales.NA_Sales,
        vgsales.Platform
FROM clean_igdb_df
INNER JOIN vgsales ON
clean_igdb_df.name = vgsales.name;
        

