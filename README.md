# RFM Analysis Using SQL

This project aims to explore a sales dataset and segmenst customers through RFM analysis. RFM analysis is a way of segmenting or indexing a customer base into similar groups based on the <b>R</b>ecency, 
<b>F</b>requency, and 
<b>M</b>onetary attributes of a customer. My goal in this project is to create customer segments from the imported data that are clear, useful, and intuitive in order to tailor marketing campaigns based on purchasing patterns.


<br><b>Skills Utilized:<br></b>
Import Tools and datatype compatibility<br>
Aggregate Functions<br>
CTE's<br>
Window Functions<br>
Subqueries
 
---

## Importing the Data

I am using Microsoft SQL Server in this project, and opted for a flat file import. I typically have the most luck with this import method as it allows more up-front customization of datatypes.

I ran into a few errors on the intial import, mostly related to datatype contstraints. After loading the file into excel and using a simple TRIM function on the problem columns, i was then able to successfully import 
the data with no errors. I assume some leading/lagging characters in the numeric columns were to blame for the issues.






## Querying the Data
After confirming the data was imported correctly, i prefer to take a look at some of the unique values and data in the dataset. While this is not necessary, i like to use it as a framework for my queries. This helps align the data exploration to the end goal and is particularly useful if you plan to to vizualize the data. <br><br>

![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/14202c20-a458-4001-9b2d-52172e5444cc)<br><br>

NOTE: The last query in this block reveals that the data for 2005 is incomplete, and only contains data from the first half of the year. This does not mean there is no insight to be gained from the data, but it is important to keep this in mind for future queries, especially when comparing data grouped by year or month.<br>

#### What is Driving Revenue?




