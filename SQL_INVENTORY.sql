-- MINT CLASSICS COMAPNY INVENTORY CASESTUDY
-- 1) Where are items stored and if they were rearranged, could a warehouse be eliminated?
-- 2) How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?
-- 3) Are we storing items that are not moving? Are any items candidates for being dropped from the product line? 

# EXPLORE THE DATA

SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM orderdetails LIMIT 10;
SELECT * FROM productlines LIMIT 10;
SELECT * FROM products LIMIT 10;
SELECT * FROM warehouses LIMIT 10;

-- How many unique products are there in the inventory?
-- there are total 110 unique products 
SELECT COUNT(DISTINCT(productName)) FROM products;

-- AS PER CATEGORY COUNT OF PRODUCTS PRESENT IN THE INVENTORY

SELECT COUNT(productLine) AS TOTAL_PRODUCTS,productLine
FROM products
GROUP BY productLine
ORDER BY TOTAL_PRODUCTS DESC;
-- it gives an overview about the no of items as per different category are present in inventory

-- TOTAL QUANTITY OF EACH PRODUCT PRESENT IN INVENTORY

SELECT SUM(quantityInStock) AS INVENTORY,productName
FROM products
GROUP BY productName
ORDER BY INVENTORY DESC;

-- Query to get item storage locations:

SELECT w.warehouseCode, w.warehouseName, p.productCode, p.productName, p.quantityInStock
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.quantityInStock DESC;

-- Query to compare inventory and sales:

SELECT p.productCode, p.productName, p.quantityInStock, IFNULL(SUM(od.quantityOrdered), 0) AS TotalSales
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
ORDER BY TotalSales DESC;

-- Query to find slow-moving items:

SELECT p.productCode, p.productName, IFNULL(SUM(od.quantityOrdered), 0) AS TotalSales
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
HAVING TotalSales = 0
ORDER BY p.productName;

