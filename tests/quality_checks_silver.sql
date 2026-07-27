--Quality Checks

/*============================
--DO NOT EXECUTE ALL AT ONCE--
============================*/

--Check for unwanted Spaces
--Expectation:No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM (prd_nm)

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1 OR prd_id IS NULL

--Expectation : No Results
SELECT cst_key
FROM silver.crm_cust_info
WHERE cst_key !=TRIM(cst_key)

--Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

SELECT * FROM silver.crm_cust_info

--Check for NULLS or Negative Numbers
--Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost <0 OR prd_cost IS NULL

--Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
FROM silver.crm_prd_info

--Check for INvalid Dates
SELECT
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0
OR LEN(sls_order_dt) !=8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

--Check for Invalid date Orders
SELECT*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--TESTING
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NOT NULL OR sls_price IS NULL
OR sls_sales <= 0 or sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

--Expectation : No Results
SELECT cst_key
FROM bronze.crm_cust_info
WHERE cst_key !=TRIM(cst_key)

--Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info





--TESTING silver.crm_sales_details
SELECT * FROM silver.crm_sales_details

