-- 1.  Xử lý whitespace bằng TRIM() --
UPDATE campaigns SET Campaign_Type = TRIM(Campaign_Type);
UPDATE campaigns SET Target_Audience = TRIM(Target_Audience);
UPDATE campaigns SET Language = TRIM(Language);
UPDATE campaigns SET Customer_Segment = TRIM(Customer_Segment);
UPDATE campaigns SET Brand = TRIM(Brand);
UPDATE campaigns SET Channel_Used = TRIM(Channel_Used);
-- 2. Xóa dòng có giá trị NULL --
DELETE FROM campaigns
WHERE Impressions IS NULL 
	OR Clicks IS NULL
    OR Leads IS NULL
    OR Conversions IS NULL
    OR Revenue IS NULL
    OR Acquisition_Cost IS NULL;
    
-- 3. Xóa Duplicate --
CREATE TABLE campaigns_tmp LIKE campaigns;
ALTER TABLE campaigns_tmp ADD PRIMARY KEY (Campaign_ID);
INSERT IGNORE INTO campaigns_tmp
SELECT * FROM campaigns
ORDER BY Campaign_ID, Campaign_Date;

DROP TABLE campaigns;
RENAME TABLE campaigns_tmp TO campaigns;

-- 4. Xóa dòng vi phạm logic funnel --
DELETE FROM campaigns
WHERE Clicks > Impressions
	OR Leads > Clicks
    OR Conversions > Leads;
    
-- 5. Xóa giá trị âm --
DELETE FROM campaigns
WHERE Impressions < 0
    OR Revenue < 0;
    
-- 6. Xử lý ngày không hợp lệ --
DELETE FROM campaigns 
WHERE Campaign_Date < '2024-01-01' OR Campaign_Date > '2025-12-31' OR Campaign_Date IS NULL;