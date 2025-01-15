-- This query can be used for dashboard reporting on Leads generated directly on the website 
SELECT 
  w.date
, w.country_code
, w.campaign_id
, c.campaign_name
, c.channel_3
, c.channel_4
, c.channel_5
, w.total_spend
, w.nb_of_sessions
, w.nb_of_signups
, w.nb_of_orders
, w.nb_of_poslite_items_ordered
, w.nb_poslite_items_dispatched
FROM staging_web_orders w
LEFT JOIN staging_channel_data c 
       ON w.campaign_id = c.campaign_id
