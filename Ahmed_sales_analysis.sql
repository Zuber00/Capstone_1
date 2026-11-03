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

