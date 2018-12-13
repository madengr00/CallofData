# CallofData
KUDataBootcamp - ETL Group Project - Video Games

**E**xtract
-----------------------------------------------------------------------------------------
For our Call of Data ETL Project, we utilized two resources for extraction. The base (vgsales.CSV) was downloaded directly from a Kaggle dataset by user gregorut (GregorySmith) and comprises over 16,500 videogames and their regional and global sales as of 10/26/2016. It was our goal to pair this videogame sales data with the games ESRB rating for further analysis. This second data set (with ESRB rating, weighted score, and popularity) comes from a RESTful API provided by the Internet Gaming Database (IGDB) and required both a HTTP header (with “user-key” : api_key and “Accept” : “application/json”) and query based on an extracted list of titles from vgsales.CSV. Running the API call, we appended the targeted values into lists. These lists were compiled into a dictionary that was converted into a dataframe and finally a .CSV document. Due to limitations of 3,000 monthly calls per API key, our ESRB data was incomplete and broken up into separate .CSVs. To work around this limitation we each utilized second API keys to first complete our dataset and then appended the individual .CSVs into one full .CSV.  The full set of API data pulled can be found in Output/full_esrb_df.csv in the repository. The original vgsales.csv from Kaggle is located in the home folder of the repository.  

**T**ransform
------------------------------------------------------------------------------------------
DATA TRASFORMATION SUMMARY:
1.    Save JSON data in lists during API call
2.    Create dictionary of unequal length lists
3.    Convert dictionary to an index oriented Pandas dataframe  *IMPORTANT!*
4.    Transpose dataframe
5.    Rename columns as needed
6.    Save as a .csv
7.    Import .csv to a new dataframe
8.    Evaluate contents of original table
9.    Drop ‘NaN’ for only  the ‘name’ and ‘esrb’ column
10.    Drop Duplicates for the ‘name’ column only
11.    Save as a new .csv for further merge / query ability in MySQL

Data from the API was JSON.   From there, we combined the data as a dictionary of lists and converted it to a Panda dataframe.  Because the lists were different lengths, the dataframe was first oriented by the indexes.    Once created, the dataframe was easily transposed to make the index into column names.    Final API call results were saved as a .csv file for later cleaning.
    The project proposal was to merge ESRB ratings of games to a table of video game sales.   Utilizing Jupyter notebooks, we verified that the columns to merge were titled the same and renamed the rating column from the API call to read “esrb” for more clarity.  The original data contained 14534 rows of video game names, but only 8703 esrb entries.   Further analysis indicated that we had many rows of data missing names and esrbs as well as duplicates.     For the purpose of the esrb / sales merge, we then dropped all ‘NA’ fields and duplicates.  Our final dataset contained 5584 records.
The final, clean, dataframe was saved as a .csv format for import to a MySQL database.  It can be found at Output/clean_igdb_df.csv in the repository.


**L**oad
--------------------------------------------------------------------------------------------
After the data was cleaned, we decided to use MySQL for our gaming database.  We loaded three separate tables (clean_igdb_df, vgasales, and ESRB).  The clean_igdb_df table contains the combined data from our separate API calls to the IGDB.  The vgasales table contains the data from the Kaggle dataset.  The ESRB table contains the value assigned by the IGDB and its corresponding rating.  These separate tables can be queried based on any combination of name, platform, year, genre, publisher, North American sales, EU sales, Japan sales, other sales, global sales, popularity, IGDB rating, and ESRB rating.  By using MySQL we can find how sales correspond to each ESRB rating, and also compare platforms or publishers to ESRB ratings or popularity.
    We developed a specific query that works with North American Sales compared to ESRB rating as ESRB ratings are specific to the USA, Mexico, and Canada.  This query can be found at Output/callofdata.sql in our repository.
