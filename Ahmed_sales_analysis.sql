-- Capstone 1: Sales Analysis
-- Sales Manager: Jim Heck
-- Sales Territory: Colorado
-- Region: West

-- 1. Total Revenue and Date Range
-- Total Rev for Jim Heck's Colorado Territory

SELECT SUM(store_sales.Sale_Amount)
FROM store_sales
INNER JOIN store_locations
ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado' ;
-- Total Rev: $6,412,632.22

SELECT MIN(store_sales.Transaction_Date) AS Start_Date, MAX(store_sales.Transaction_Date) AS End_Date
FROM store_sales
INNER JOIN store_locations
ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado';
-- Start Date: 2022-01-01
-- End Date: 2025-12-31

-- Revenue breakdown by year and month

SELECT MONTH(store_sales.Transaction_Date) AS Sales_Month, YEAR(store_sales.Transaction_Date) AS Sales_Year, SUM(store_sales.Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY Sales_Year, Sales_Month
Order BY Sales_Year, Sales_Month;

SELECT *
FROM management
WHERE Region = 'West';

SELECT *
FROM online_sales;

SELECT SUM(online_sales.SalesTotal)
FROM online_sales
-- Total_Rev for Online_stores = $68,004,827.05
-- Entire Region sales: Colorado $6,412,632.22) + Online($68,004,827.05) = $74,417,459.27
-- Out of the $74,417,459.27 the region made, $6,412,632.22 is from Colorado (8.6% of Total_Rev)

-- Q4
SELECT *
FROM products

SELECT *
FROM inventory_subcategories ;

SELECT *
FROM inventory_categories

SELECT id
FROM store_sales

SELECT inventory_categories.Category, 
	MONTH(store_sales.Transaction_Date) AS Sales_Month, YEAR(store_sales.Transaction_Date) AS Sales_Year,
	COUNT(store_sales.id) AS Transaction_Count, AVG(store_sales.Sale_Amount) AS AVG_Transaction
FROM store_sales
INNER JOIN products
	ON products.ProdNum = store_sales.Prod_Num
INNER JOIN inventory_subcategories
	ON inventory_subcategories.Subcategoryid = products.Subcategoryid
INNER JOIN inventory_categories
	ON inventory_categories.Categoryid = inventory_subcategories.Categoryid
INNER JOIN store_locations
	ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY inventory_categories.Category, Sales_Month, Sales_Year
ORDER BY inventory_categories.Category, Sales_Year, Sales_Month ;

SELECT DISTINCT StoreId
FROM store_locations
WHERE State = 'Colorado' ;

SELECT Store_ID, SUM(Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
	ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY store_sales.Store_ID
ORDER BY Total_Rev ASC ;

SELECT AVG(Total_Rev)
FROM (SELECT Store_ID, SUM(Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
	ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY store_sales.Store_ID 
) AS Store_Rev
-- AVG Colorado store revenue: $356,257.35
-- Focus on improving stores below the avg by: Identifying low selling items &  better selling strategies
