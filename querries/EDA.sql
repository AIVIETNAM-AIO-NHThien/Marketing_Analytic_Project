USE marketing_analytics;

-- 1. Kiểm tra giá trị unique --
SELECT DISTINCT Campaign_Type FROM campaigns;
SELECT DISTINCT Brand FROM campaigns;
SELECT DISTINCT Customer_Segment FROM campaigns;


-- 2. Kiểm tra giá trị NULL --
SELECT 
	SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END) as null_impression,
    SUM(CASE WHEN Clicks IS NULL THEN 1 ELSE 0 END) as null_clicks,
    SUM(CASE WHEN Leads IS NULL THEN 1 ELSE 0 END) as null_leads,
    SUM(CASE WHEN Conversions IS NULL THEN 1 ELSE 0 END) as null_conversions,
    SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) as null_revenue,
    SUM(CASE WHEN Acquisition_Cost IS NULL THEN 1 ELSE 0 END) as null_acqui
FROM campaigns;

-- 3. Kiểm tra duplicate --
SELECT Campaign_ID, COUNT(*) as duplicate_ID
FROM campaigns
GROUP BY Campaign_ID
HAVING COUNT(*) > 1
ORDER BY duplicate_ID DESC
LIMIT 10;

-- 4. Logic tunnel --
SELECT
	SUM(CASE WHEN Clicks > Impressions THEN 1 ELSE 0 END) as Click_vs_Impression,
    SUM(CASE WHEN Leads > Clicks THEN 1 ELSE 0 END) as Lead_vs_Click,
    SUM(CASE WHEN Conversions > Leads THEN 1 ELSE 0 END) as Conversions_vs_Click
FROM campaigns
WHERE Impressions IS NOT NULL 
	AND Clicks IS NOT NULL;
    
-- 5. Kiểm tra giá trị âm --
SELECT
	SUM(CASE WHEN Impressions < 0 THEN 1 ELSE 0 END) as invalid_Impression,
    SUM(CASE WHEN Revenue < 0 THEN 1 ELSE 0 END) as invalid_Revenue
FROM campaigns;

-- 6. Kiểm tra ngày không hợp lệ --
SELECT Campaign_Date, COUNT(*) AS cnt
FROM campaigns
WHERE Campaign_Date IS NOT NULL
	AND STR_TO_DATE(Campaign_Date, '%d-%m-%Y') IS NULL
GROUP BY Campaign_Date;

-- 7. đếm số ngày không hợp lệ -- 
SELECT COUNT(*) AS out_of_range
FROM campaigns
WHERE Campaign_Date < '2024-01-01' OR Campaign_Date > '2025-12-31';
SELECT COUNT(*) AS null_dates
FROM campaigns
WHERE Campaign_Date IS NULL;
