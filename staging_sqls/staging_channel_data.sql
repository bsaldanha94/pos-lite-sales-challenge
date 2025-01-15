WITH raw_data AS (
-- Removed rows with Null values in campaign name and channel_5 columns 
SELECT *
FROM channels 
WHERE (campaign_name IS NOT NULL) AND (channel_5 IS NOT NULL)
)
, cleaned_channel_data AS (
-- Removed all white spaces in campaign_name, channel_3, channel_4 channel_5 columns
-- Dropped column campaign_period_budget_category 
SELECT 
  campaign_id
, REPLACE(campaign_name, ' ', '') AS campaign_name
, campaign_period_budget_category
, REPLACE(channel_3, ' ', '')  AS channel_3
, REPLACE(channel_4, ' ', '') AS channel_4
, REPLACE(channel_5, ' ', '') AS channel_5
FROM raw_data
) 
, deduplicated_channel_data AS (
-- Removed duplicates so that only unique values remain
SELECT DISTINCT 
  campaign_id
, campaign_name
, channel_3
, channel_4
, channel_5
FROM cleaned_channel_data
)
SELECT * 
FROM deduplicated_channel_data
