INSERT INTO silver.erp_cust_az12 (cid,bdate, gen)

SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
	ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'Male'
	ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12
WHERE cid NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)






/*
--Identify OUT-of -Range Dates
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()
*/



/*
--Data Standardization & Consistency
SELECT DISTINCT 
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'FEMALE'
	WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'MALE'
	ELSE 'n/a'
END AS gen
FROM silver.erp_cust_az12
*/
