DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_product AS

-- 1. Standardize the codes first (Uppercase and Trimmed)
WITH CleanedCodes AS (
    SELECT 
        UPPER(TRIM(StockCode)) AS Clean_StockCode, 
        Description,
        InvoiceDate
    FROM cleaned_retail
    WHERE Description IS NOT NULL AND TRIM(Description) != ''
),

-- 2. Now find the duplicates based on the perfectly clean codes
RankedProducts AS (
    SELECT 
        Clean_StockCode AS StockCode,
        Description,
        ROW_NUMBER() OVER(PARTITION BY Clean_StockCode ORDER BY InvoiceDate DESC) as rn
    FROM CleanedCodes
)

-- 3. Keep only the true #1
SELECT 
    StockCode, 
    Description 
FROM RankedProducts 
WHERE rn = 1;