WITH  raw_data AS (
-- Removed rows with unknown and null values in campaign_name and campaign_id columns 
-- Casted values in campaign_id column to Integer datatype to be consistent
SELECT 
  date
, currency
, country
, CAST(campaign_id AS INTEGER) AS campaign_id 
, REPLACE(campaign_name, ' ', '') AS campaign_name
, product
, channel_3
, channel_4
, channel_5 
, total_impressions
, total_clicks
, total_spends
, total_leads
, total_fake_leads
, total_sql
, total_meeting_done
, total_signed_leads
, total_pos_lite_deals
FROM leads_funnel
WHERE (campaign_name <> ‘unknown’) AND (campaign_id IS NOT NULL)
)
, campaign_lookup AS (
-- Temp lookup table with list of campaign ids and campaign names
SELECT DISTINCT 
  campaign_id
, campaign_name 
FROM raw_data
)
, cleaned_leads_data AS (
-- Replaced null values in campaign_id and campaign_name columns with values from campaign lookup CTE
-- Cleaned values in product column
SELECT 
  date
, currency
, country
, COALESCE(l.campaign_id, c.campaign_id) AS campaign_id
, COALESCE(l.campaign_name, c.campaign_name) AS campaign_name
, CASE WHEN product = ‘unknown’ AND regexp_like(campaign_name, ‘pos-lite’) THEN ‘pos-lite’
           WHEN (product IS NULL) AND regexp_like(campaign_name, ‘poslite-cr’) THEN ‘poslite-cr’
           WHEN (product IS NULL) AND regexp_like(campaign_name, ‘pos-lite’) THEN ‘pos-lite’
            ELSE product END AS product 
, channel_3
, channel_4
, channel_5 
, COALESCE(total_impressions, 0) AS total_impressions
, COALESCE(total_clicks, 0) AS total_clicks
, COALESCE(total_spends, 0) AS total_spends
, total_leads
, total_fake_leads
, total_sql
, total_meeting_done
, total_signed_leads
, total_pos_lite_deals
FROM raw_data AS l
LEFT JOIN campaign_lookup AS c 
              ON l.campaign_id = c.campaign_id
)
SELECT *
FROM cleaned_leads_data
