 USE marketing_analytics;

LOAD DATA LOCAL INFILE 'D:/Project_Marketing_AIO/data/tira_campaign_data.csv'
INTO TABLE campaigns
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Campaign_ID, Campaign_Type, Target_Audience,Duration,
Channel_Used, Impressions, Clicks, Leads, Conversions,
Revenue, Acquisition_Cost, ROI, Language,
Engagement_Score, Customer_Segment, @date_raw)
SET Campaign_Date = STR_TO_DATE(@date_raw, '%d-%m-%Y');

UPDATE campaigns SET Brand = 'Tira'
WHERE Campaign_ID LIKE 'TI-%' AND Brand IS NULL;