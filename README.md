# Enterprise Retail Analytics Platform (UK Online Retail II)

An end-to-end Business Intelligence and Data Engineering portfolio project. This repository contains the SQL Medallion staging pipeline and an interactive Power BI desktop tool designed to transform ~1,000,000 rows of raw e-commerce transaction logs into C-suite strategic insights.

---

## 1. Data Overview

* **Source Dataset:** UK Online Retail II Historical Logs (2009–2011).
* **Volume:** ~1,000,000 unindexed transactional line items.
* **Architecture:** Staged in SQL via a **Medallion Pipeline** (Bronze $\rightarrow$ Silver $\rightarrow$ Gold) and imported into Power BI as a normalized **Star Schema** (`fact_sales` surrounded by `dim_customer`, `dim_product`, and `Dim_Date`).
* **Sanitation Protocol:** Engineered SQL `COALESCE` handling to capture millions in unauthenticated checkout traffic under a centralized `'Guest'` key. Purged over **£240,000+** in non-physical administrative ledger noise (e.g., Amazon platform fees, manual bank charges) from warehouse logistics metrics via DAX string-exclusion flags.

---

## 2. North Star Metrics & Dimensions Used

### Core KPIs (North Star)
* **Gross Revenue (£19.45M):** Total baseline cash flow captured prior to order cancellations.
* **Net Revenue (£18.73M):** True realized topline cash generated (`Gross Revenue - Lost to Returns`).
* **Lost to Returns (£711.91K):** Sanitized monetary value of defective or cancelled physical merchandise.
* **Return Rate % (3.66%):** Percentage of gross volume leaked to physical inventory returns.

### Primary Analytical Dimensions
* **Chronological:** Year, Fiscal Quarter, Year-Month Indexing.
* **Geographic:** UK Core vs. International Expansion Markets (Top 10 Ex-UK territories).
* **Customer Segments:** Authenticated Corporate/B2B Accounts vs. Unregistered 'Guest' checkouts.
* **Inventory:** Physical SKU Descriptions, Line-Item Refund Totals.

---

## 3. Summary of Insights & Strategic Recommendations

### Page 1: Executive Summary (Macro Topline)

![Executive Summary Dashboard](screenshots/executive_summary.png)

#### 🔍 Key Insights
1. **Extreme Q4 Seasonality:** The business is heavily bound to holiday consumer cycles. Revenue consistently languishes in Q1–Q3 before initiating aggressive vertical climbs in August, ultimately peaking every November (generating ~£1.5M/month).
2. **Stagnant Return Rates Despite Flat Growth:** Year-over-Year gross revenue growth between 2010 and 2011 was virtually flat (**+0.97%**). However, physical return losses nearly doubled from £237K (2010) to £454K (2011), driving the annual return rate up from **2.56% to 4.85%**. 

#### 🚀 Strategic Recommendations
* **Establish Q1 Cash Reserves:** Leadership must cease treating Q4 peak cash flow as operational surplus. The finance department should institute a strict treasury policy to ring-fence November profits to subsidize the predictable liquidity droughts experienced every January–April.
* **Initiate 2011 Return Root-Cause Analysis:** Operations must investigate why product returns accelerated in 2011 despite flat topline sales. This divergence indicates emerging manufacturing defects, declining packaging standards, or inaccurate website product listings rather than organic sales volume scaling.

---

### Page 2: Geographic & Customer Strategy (Commercial Operations)

![Geographic and Customer Insights Dashboard](screenshots/geographic_customer_insights.jpg)

#### 🔍 Key Insights
1. **Heavy UK Over-Reliance:** The domestic UK market captures **85%** of all historical net revenue. When isolating the remaining 15% international share, **EIRE (Ireland) (£0.61M)** and **Mainland Europe** (Netherlands: £0.54M, Germany: £0.37M) clearly dominate. 
2. **Emerging Secondary Markets:** Tier-2 European nations (Switzerland, Spain, Belgium, Sweden, Denmark) consistently appear in the Top 10 international leaderboard despite receiving zero localized marketing focus.
3. **The Unregistered Checkout Anomaly:** Unauthenticated **'Guest' checkouts generated £2.8M** in revenue—nearly **5x more volume** than the company’s single largest registered corporate B2B client (`CustomerID 18102` at £0.6M).

#### 🚀 Strategic Recommendations
* **Target Western European Ad Spend:** Marketing should halt scattered global ad-spend and concentrate international expansion budgets strictly into EIRE, the Netherlands, and Germany to build regional fulfillment density.
* **Launch Secondary Market Experiments:** Allocate 10% of the growth budget to test localized currency checkout and translated landing pages in Switzerland and Spain to capitalize on organic baseline demand.
* **Plug the Guest Data Leak:** The business is hemorrhaging customer lifetime value (LTV) tracking. E-commerce teams must immediately introduce post-checkout incentives (e.g., *"Create a password now to track this order and receive 10% off your next purchase"*) to convert the £2.8M anonymous buyer pool into trackable, marketable accounts.

---

### Page 3: Product Performance (Warehouse Logistics)

![Product Performance Dashboard](screenshots/product_performance.png)

#### 🔍 Key Insights
1. **Concentrated Hero SKUs:** Physical product sales are anchored by a small cluster of household decorative items. The **Regency Cakestand 3-Tier (£314K)** and **White Hanging Heart T-Light Holder (£252K)** represent undeniable inventory cash cows.
2. **Severe Margin-Leaking SKUs:** The **'Paper Craft, Little Birdie'** SKU represents a catastrophic operational failure: it generated £168,470 in gross revenue, but logged **£168,470 in refunds**, resulting in a **100% net loss** to the warehouse. Similarly, **Medium Ceramic Storage Jars** leaked £77,480 in refunds against £81,701 in sales.

#### 🚀 Strategic Recommendations
* **Ring-Fence Hero SKU Supply Chains:** The supply chain director must establish automated re-order point (ROP) thresholds for the Cakestand and T-Light holders. Stockouts on these two specific SKUs during the August–November ramp-up represent the single largest existential threat to annual company revenue.
* **Quarantine Defective Batches:** Quality Assurance must immediately halt procurement and audit the manufacturing line for *Paper Craft* and *Ceramic Storage Jars*. A 95%+ return rate points to severe factory defects or fragile transit packaging that cannot survive standard postal freight.

---

## 4. Technical File Structure

* `enterprise_retail_analytics.pbix`: Master Power BI Desktop application containing the indexed Star Schema and report canvas.
* `/sql_pipeline`: DDL and DML scripts utilized for Bronze-to-Gold data transformation and null handling.
* `/screenshots`: High-resolution dashboard renders utilized for executive documentation.
