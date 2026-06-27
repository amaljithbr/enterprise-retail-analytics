-- 1. Clear the runway in case you've run this before
DROP TABLE IF EXISTS cleaned_retail;

-- 2. Create the new Silver table
CREATE TABLE cleaned_retail AS

-- 3. Use CTE 
WITH ranked_sales AS (
    SELECT 
        Invoice,
        StockCode,
        TRIM(Description) AS Description,
        Quantity,

        -- Converts Excel text into a real MySQL DateTime
        STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i') AS True_InvoiceDate, 
        
        Price,
        
        -- Replaces missing customers with 'Guest'
         COALESCE(NULLIF(TRIM(CustomerID), ''), 'Guest') AS CustomerID,
        
        Country,
        
        -- Pre-calculates your revenue metric for Power BI
        (Quantity * Price) AS Total_Sales,
        
        -- Flags refunds with a 1, keeps normal sales as 0
        CASE WHEN Invoice LIKE 'C%' THEN 1 ELSE 0 END AS is_cancelled,
        
        -- Tags duplicate rows with 1, 2, 3...
        ROW_NUMBER() OVER (
            PARTITION BY Invoice, StockCode, Quantity, InvoiceDate 
            ORDER BY Invoice
        ) AS duplicate_flag
        
    FROM raw_retail
    
    -- Filter 1: Kills Zero prices, Freebies, and Forklift damages
    -- Filter 2: Kills Bad Debt phantoms ('A' invoices)
    WHERE Price > 0 
      AND Invoice NOT LIKE 'A%' 
)

-- 4. Select the final, polished columns to populate the table
SELECT 
    Invoice,
    StockCode,
    Description,
    Quantity,
    True_InvoiceDate AS InvoiceDate,
    Price,
    CustomerID,
    Country,
    Total_Sales,
    is_cancelled
FROM ranked_sales
WHERE duplicate_flag = 1; -- Filter 3: Only keeps the first instance of duplicates;
