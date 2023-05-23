--import check
SELECT * FROM sales_data..rfm_data

--unique values
SELECT DISTINCT status FROM sales_data..rfm_data; --potential tableau plot
SELECT DISTINCT year_id FROM sales_data..rfm_data;
SELECT DISTINCT productline FROM sales_data..rfm_data; --potential tableau plot
SELECT DISTINCT country FROM sales_data..rfm_data; -- potential tableau plot
SELECT DISTINCT dealsize FROM sales_data..rfm_data; --potential tableau plot


--Data Exploration
--- group sales by product line
SELECT 
	productline, 
	ROUND(sum(sales), 2) as revenue
FROM sales_data..rfm_data
GROUP BY productline
ORDER BY 2 desc
 ;

----revenue by year
SELECT 
	YEAR_ID, 
	ROUND(sum(sales), 2) as revenue
FROM sales_data..rfm_data
GROUP BY YEAR_ID
ORDER BY 2 desc
 ;

 ----by dealzise
SELECT 
	DEALSIZE, 
	ROUND(sum(sales), 2) as revenue
FROM sales_data..rfm_data
GROUP BY DEALSIZE
ORDER BY 2 desc
 ;

 ----best month for sales in a specific year. also return the amount that was earned
SELECT 
	MONTH_ID, 
	ROUND(sum(sales), 2) as revenue, 
	COUNT(ordernumber) as frequency 
FROM sales_data..rfm_data
WHERE YEAR_ID = 2003 --use if looking for data on specific year
	--WHERE YEAR_ID IN (2003, 2004) use if looking for data from muiltiple specified years
GROUP BY MONTH_ID
ORDER BY 2 desc
 ;

--november being the highest revenue month, which products are selling in november 2003?
SELECT 
	MONTH_ID, 
	PRODUCTLINE, 
	ROUND(sum(sales), 2) as revenue,
	COUNT(ordernumber) as frequency 
FROM sales_data..rfm_data
WHERE YEAR_ID = 2003 AND MONTH_ID = 11 --change WHERE clause values to specify year and month
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 desc
 ;

 --RFM (indexing by segmenting customers. recency(how long since last purchase), frequency(how often they purchase), Monetary(how much they spend)
 ----who is our top customer?

DROP TABLE IF EXISTS #rfm; 
with rfm as
(
	SELECT
		CUSTOMERNAME, 
		SUM(sales) as monetary_value, 
		AVG(sales) as avg_monetary_value, 
		COUNT(ORDERNUMBER) as frequency, 
		MAX(ORDERDATE) as last_order_date, 
		(SELECT MAX(ORDERDATE) FROM sales_data..rfm_data) as max_order_date, 
		DATEDIFF(DD, max(ORDERDATE), (SELECT MAX(ORDERDATE) FROM sales_data..rfm_data)) as recency 

	FROM sales_data..rfm_data 
	GROUP BY CUSTOMERNAME
), 
rfm_calc as 
( 
	
	SELECT r.*, 
		NTILE(4) OVER (ORDER BY recency desc) as rfm_recency, 
		NTILE(4) OVER (ORDER BY frequency) as rfm_frequency, 
		NTILE(4) OVER (ORDER BY monetary_value) as rfm_monetary 
	FROM rfm r
)

SELECT 
	c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell, 
	CAST(rfm_recency AS VARCHAR) + CAST(rfm_frequency AS VARCHAR) + CAST(rfm_monetary AS VARCHAR) as rfm_cell_string 
INTO #rfm
FROM rfm_calc c
;


SELECT 
	CUSTOMERNAME, 
	rfm_recency, 
	rfm_frequency, 
	rfm_monetary, 
	CASE 
		WHEN rfm_cell_string IN (111, 112, 121, 122, 123, 132, 211, 212, 114, 141)   --customers who have not made a purchase in a substantial amount of time
			THEN 'dormant customers' 
		WHEN rfm_cell_string IN (133, 134, 143, 244, 344, 343, 344, 144) --larger spenders who have not purchased recently
			THEN 'decreasing volume, want to retain' 
		WHEN rfm_cell_string IN (311, 411, 331, 412)
			THEN 'new customers' 
		WHEN rfm_cell_string IN (222, 223, 233, 233, 322, 421, 232, 234)
			THEN 'potential churners' 
		WHEN rfm_cell_string IN (323, 333, 321, 422, 332, 432, 221, 423) --customers who buy frequently at lower price points
			THEN 'active' 
		WHEN rfm_cell_string IN (433, 434, 443, 444)
			THEN 'power buyers' 
		END as rfm_segment
FROM #rfm
;


-- Products commonly sold together
SELECT DISTINCT ORDERNUMBER, STUFF(

	(SELECT ','+ PRODUCTCODE
	FROM sales_data..rfm_data p
	WHERE ORDERNUMBER IN
		(
		SELECT ORDERNUMBER
		FROM (
			SELECT 
				ORDERNUMBER, 
				COUNT(*) as rn
			FROM sales_data..rfm_data 
			WHERE STATUS = 'shipped'
			GROUP BY ORDERNUMBER
			) m 
		WHERE rn =3
	)
	AND p.ORDERNUMBER = s.ORDERNUMBER 
	FOR xml path (''))
		
		, 1, 1, '') as product_code
FROM sales_data..rfm_data as s
ORDER BY 2 DESC
;