USE marketing_analytics;

-- Tao bang chua du lieu campaign (gop ca 3 brands)
CREATE TABLE IF NOT EXISTS campaigns (
Campaign_ID VARCHAR(20), -- chua dat PRIMARY KEY: du lieu tho con trung
Brand VARCHAR(20),
Campaign_Type VARCHAR(50),
Target_Audience VARCHAR(100),
Duration INT,
Channel_Used VARCHAR(200),
Impressions INT,
Clicks INT,
Leads INT,
Conversions INT,
Revenue INT,
Acquisition_Cost DECIMAL(10, 2),
ROI DECIMAL(10, 4),
Language VARCHAR(50),
Engagement_Score DECIMAL(5, 2),
Customer_Segment VARCHAR(100),
Campaign_Date DATE
 );
