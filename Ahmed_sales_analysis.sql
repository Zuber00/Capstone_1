-- Capstone 1: Sales Analysis
-- Sales Manager: Jim Heck
-- Sales Territory: Colorado
-- Region: West

-- 1. What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?

-- Total Rev for Jim Heck's Colorado Territory

SELECT SUM(store_sales.Sale_Amount) AS Total_Revenue
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

-- 2.What is the revenue breakdown by year and month for the sales territory?
--  Revenue breakdown by year and month

SELECT MONTH(store_sales.Transaction_Date) AS Sales_Month, YEAR(store_sales.Transaction_Date) AS Sales_Year, SUM(store_sales.Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY Sales_Year, Sales_Month
Order BY Sales_Year, Sales_Month;

-- 3. Provide a comparison of total revenue for the specific sales territory and the region it belongs to
--  Total Revenue Comparison

-- (Supporting queries to identify west region management and online sales data)
SELECT *
FROM management
WHERE Region = 'West';

SELECT *
FROM online_sales;

-- SQL Main analysis: compare Colorado territory revenue with total online sales to evaluate the territory's contribution to west regional sales.
SELECT SUM(online_sales.SalesTotal) AS Total_Online_Sales
FROM online_sales
-- Total_Rev for Online_stores = $68,004,827.05
-- Entire Region sales: Colorado $6,412,632.22) + Online($68,004,827.05) = $74,417,459.27
-- Out of the $74,417,459.27 the region made, $6,412,632.22 is from Colorado (8.6% of Total_Rev)

-- 4. What is the number of transactions per month and average transaction amount by product
-- category for the sales territory?
-- (Supporting queries to identify west region management and online sales data)
SELECT *
FROM products

SELECT *
FROM inventory_subcategories ;

SELECT *
FROM inventory_categories

SELECT id
FROM store_sales

-- SQL Main analysis: Monthly transaction count and average transaction amount by product category
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

-- 5. Can you provide a ranking of in-store sales performance by each store in the sales territory, or a
-- ranking of online sales performance by state within an online sales territory? 
SELECT DISTINCT StoreId
FROM store_locations
WHERE State = 'Colorado' ;

-- Main analysis -- Rank Colorado stores by total in-store revenue, highest to lowest
SELECT Store_ID, SUM(Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
	ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY store_sales.Store_ID
ORDER BY Total_Rev DESC ;

-- 6. What is your recommendation for where to focus sales attention in the next quarter?
SELECT AVG(Total_Rev)
FROM (SELECT Store_ID, SUM(Sale_Amount) AS Total_Rev
FROM store_sales
INNER JOIN store_locations
	ON store_locations.StoreId = store_sales.Store_ID
WHERE store_locations.State = 'Colorado'
GROUP BY store_sales.Store_ID 
) AS Store_Rev
-- Recommendation: Prioritize stores 701, 703, 706, 707, 708, 710, and 716 because their revenue is below the average of $356,257,.35 for Colorado physical stores
-- AVG Colorado store revenue: $356,257.35

