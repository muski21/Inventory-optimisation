# Inventory-optimisation
SQL Project for Inventory Optimisation

## PROJECT OVERVIEW
This project aims to support Mint Classics Company, a retailer of classic model cars and other vehicles  in making a data-driven decision to close one of their storage facilities. The analysis focuses on reorganizing and reducing inventory while maintaining timely customer service.

# WHAT ARE THE OBJECTIVES?
- Identify where items are stored and evaluate if a warehouse can be eliminated.
- Analyze inventory numbers in relation to sales figures.
- Identify slow-moving items that could be candidates for removal from the product line.

## Data Description
The analysis uses data from the following tables:

- warehouses: Information about storage facilities.
- products: Details about products and inventory levels.
- productlines: Product categories.
- payments: Customer payments.
- orders: Customer orders.
- orderdetails: Details of each order.
- offices: Office locations.
- employees: Employee information.
- customers: Customer information.

## METHODOLOGY
### Step 1
 Identify item storage locations
 Analyze where items are stored to determine if a warehouse can be eliminated based on inventory levels.

  -- Query to get item storage locations:

SELECT w.warehouseCode, w.warehouseName, p.productCode, p.productName, p.quantityInStock
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY p.quantityInStock DESC;

### Step 2
 Compare inventory levels with sales figures to assess if inventory counts are appropriate.

-- Query to compare inventory and sales:

SELECT p.productCode, p.productName, p.quantityInStock, IFNULL(SUM(od.quantityOrdered), 0) AS TotalSales
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
ORDER BY TotalSales DESC;

### Step 3
 Identify Slow moving items
 Find items with low or zero sales to consider for removal.

-- Query to find slow-moving items:

SELECT p.productCode, p.productName, IFNULL(SUM(od.quantityOrdered), 0) AS TotalSales
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode
HAVING TotalSales = 0
ORDER BY p.productName;

# KEY-FINDINGS
Item Storage Location: Items like the "1985 Toyota Supra" are stored in Warehouse A, which has significant unused capacity.

Potential for Consolidation: Warehouses with lower inventory counts may be candidates for consolidation.

Inventory vs. Sales: The "1985 Toyota Supra" has zero sales but substantial inventory, indicating it is not moving.

Slow-Moving Items: Items with zero sales were identified, suggesting they are candidates for removal to optimize inventory.


# Recommendations:

- Removing slow moving items from the inventory.
- Consolidate Warehouses to optimize space utilization.
