-- 1. Tong rows
SELECT COUNT(*) AS total_rows FROM campaigns;

-- 2. NULL check
SELECT
	(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END)
	AS null_imp,
	SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END)
	AS null_rev
FROM campaigns;

-- 3. Duplicate check
SELECT COUNT(*) FROM (
SELECT Campaign_ID FROM campaigns
GROUP BY Campaign_ID HAVING COUNT(*) > 1) t;

-- 4. Funnel logic check
SELECT 
    SUM(CASE 
        WHEN Clicks > Impressions 
         OR Leads > Clicks 
         OR Conversions > Leads 
        THEN 1 ELSE 0 
    END) AS total_errors
FROM campaigns;
-- 5. Negative check
SELECT 
	SUM(CASE WHEN Impressions < 0 OR Revenue < 0
		THEN 1 ELSE 0 END) AS negatives FROM campaigns;

-- 6. Du lieu da sach -> gio moi dat PRIMARY KEY cho Campaign_ID
ALTER TABLE campaigns ADD PRIMARY KEY (Campaign_ID);
