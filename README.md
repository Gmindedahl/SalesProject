# RFM Analysis Using SQL

This project aims to explore a sales dataset and segment customers through RFM analysis. RFM analysis is a way of segmenting or indexing a customer base into similar groups based on the <b>R</b>ecency, 
<b>F</b>requency, and 
<b>M</b>onetary attributes of a customer. My goal in this project is to create customer segments that are clear, useful, and intuitive to tailor marketing campaigns based on purchasing patterns.


<br><b>Skills Utilized:<br></b>
Import Tools and datatype compatibility<br>
Aggregate Functions<br>
CTE's<br>
Subqueries
 
---

## Importing the Data

I am using Microsoft SQL Server in this project, and opted for a flat file import. I typically have the most luck with this import method as it allows more up-front customization of datatypes.

I ran into a few errors on the intial import, mostly related to datatype contstraints. After loading the file into excel and using a simple TRIM function on the problem columns, i was able to successfully import 
the data with no errors. I assume some leading/lagging characters in the numeric columns were to blame for the errors.






## Querying the Data
After confirming the data was imported correctly, i prefer to take a look at some of the unique values and data in the dataset. While this is not necessary, i like to use it as a framework for my queries. This helps align the data exploration to the end goal and is particularly useful if you plan to to vizualize the data. <br><br>

![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/14202c20-a458-4001-9b2d-52172e5444cc)<br><br>

NOTE: The last query in this block reveals that the data for 2005 is incomplete, and only contains data from the first 5 months of the year. This does not mean there is no insight to be gained from the data, but it is important to keep this in mind for future queries, especially when comparing data grouped by year or month.<br>

### What is Driving Revenue?

To further explore the data i wanted to take a look at revenue generation for this company. This is not completely necessary for this project but i find further data exploration is rarely detrimental, and will aid in narrowing the segmentation criteria during the RFM analysis. <br><br>


#### Revenue by Product Line
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/28dfb8e0-3e06-475a-8ba0-0910104b0686)
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/c12c8f20-bc0e-4549-8d5d-263df438ae1e)

#### Revenue by Deal Size
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/560a60ac-47b4-42e4-a92c-27a84cd5f654)
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/6706c7ff-64f2-40e6-b2c3-e958e74f2e66)

#### Revenue and Purchase Count by Month

![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/e6a5fd44-d27c-4566-b222-cdffef056eda)
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/19dbf044-0939-4244-8532-758b2e684e2a)<br><br>
 NOTE: The results shown here are for one specified year, 2003. The commented out WHERE clause can be used to query multiple specified years in aggregate.<br><br>
 
 #### If November is the Highest Grossing Month, Which Products are Sold Most in November?
 
 ![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/0bd4f1a1-6102-44c7-9048-3def9623883a)
 ![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/c3ec65c7-a1c9-4c3d-ac73-0637faf16763)
 
 # RFM Analysis

The idea behind this analysis is to assign a recency, frequency, and monetary value (1-4) to each customer based on an aggregation of the associated data points. Once values have been assigned in each category, we can then cast the numerical values to VARCHAR and combine them into a single string, for example, '124', '312', '423'.<br><br>
We will need to use a CTE in order to accomplish this. The full query is shown here:<br><br>


![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/ee354bf4-bb55-4819-9da9-de73e4de87a1)<br><br>

After executing this query, we can use the new values to group the customers into meaningful buckets. For example, an rfm string of '111' means that the customer is in the lowest quartile of each recency, frequency, and monetary aggregation. I will use a CASE statement in the following query to label the three character strings into named categories. You will see the above customer with string '111' placed into the dormant customers group.<br>

![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/019d5bb8-f303-4d06-a388-137133746f0a)
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/4089fb21-32bd-4a76-bccd-7abec14e2435)<br><br>


---

# Conclusion
Now that each customer has successfully been assigned to a group, it is easy to tailor information or marketing material to their specific needs. Offering return discounts to 'dormant customers' or volume discounts to 'power buyers' is now easily manageable. With a simple query returning customername, address, and email based on rfm_segment Column, we can provide email lists and address lists for each of the customers in that group.<br><br>

Below I will attach the column names and datatypes for reference to the above queries.

![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/1c67f533-ce9a-4395-9672-c259eed0541e)
![image](https://github.com/Gmindedahl/sql_rfm/assets/132941581/7f88bc0a-c7a5-4ab6-96d4-07b30c5d4509)




















