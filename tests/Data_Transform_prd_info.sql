INSERT INTO silver.crm_prd_info
(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id, --Extract Category ID
    SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,      --Extract Product Key
    TRIM(prd_nm),
    ISNULL(prd_cost,0),
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'N/A'
    END,
    CAST(prd_start_dt AS DATE),
    CAST(
        LEAD(prd_start_dt) OVER
        (
            PARTITION BY SUBSTRING(prd_key,7,LEN(prd_key))
            ORDER BY prd_start_dt
        ) - 1
        AS DATE
    )
FROM bronze.crm_prd_info;

