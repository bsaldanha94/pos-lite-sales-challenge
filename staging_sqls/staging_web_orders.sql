WITH country code_lookup AS (
-- Temp lookup table with list of country codes and campaign ids
SELECT DISTINCT country_code 
, campaign_id 
FROM web_orders 
)
, order_data AS (
-- Removing rows with null values in date and campaign_id columns and replacing unknown values in with null values
SELECT date
, CASE WHEN country_code = ‘unknown’ THEN NULL ELSE country_code END AS country_code
, CAST(campaign_id AS INTEGER) AS campaign_id 
, total_spend
, nb_of_sessions
, nb_of_signups
, nb_of_orders
, nb_of_poslite_items_ordered
, nb_poslite_items_dispatched
FROM web_orders
WHERE (date IS NOT NULL) AND (campaign_id IS NOT NULL)
)
, cleaned_order_data AS (
SELECT 
-- Imputing values in country_code column from lookup table
  date
, COALESCE(o.country_code, c.country_code) AS country_code
, o.campaign_id
, total_spend
, nb_of_sessions
, nb_of_signups
, nb_of_orders
, nb_of_poslite_items_ordered
, nb_poslite_items_dispatched
FROM order_data AS o
LEFT JOIN country_code_lookup AS c
	       ON o.campaign_id = c.campaign_id
)
SELECT *
FROM cleaned_order_data
