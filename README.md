# RFM Analysis Using SQL

This project aims to explore a sales dataset and segmenst customers through RFM analysis. RFM analysis is a way of segmenting or indexing a customer base into similar groups based on the <b>R</b>ecency, 
<b>F</b>requency, and 
<b>M</b>onetary attributes of a customer. My goal in this project is to create customer segments from the imported data that are clear, useful, and intuitive in order to tailor marketing campaigns based on purchasing patterns.


<b>Skills Utilized:<br>
Import Tools and datatype compatibility<br>
Aggregate Functions<br>
CTE's<br>
Window Functions<br>
Subqueries

</b> 


## Importing the Data

I am using Microsoft SQL Server in this project, and i opted for a flat file import. I typically have the most luck with this import method as it allows more up-front customization of datatypes.

I ran into a few errors on the intiial import, mostly related to datatype contstraints. After loading the file into excel and using a simple TRIM formula on the problem columns, i was able to successfully import 
the data with no errors. I assume some leading/lagging characters were to blame.

## Querying the Data
After confirming the data was imported correctly, i prefer to take a look at some of the unique values and data in the dataset. While this is not necessary, i like to use it as a framework for my queries. This helps align the data exploration to the end goal and is particularly useful if you plan to to vizualize the data. 
