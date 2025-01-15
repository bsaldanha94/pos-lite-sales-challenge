# pos-lite-sales-challenge
Take-home challenge for SumUp

In order to answer the questions in the challenge, 3 staging tables were created:
- **staging_web_order_data**
- **staging_channel_data**
- **staging_sales_funnel_data**

Issues identified with **web_order** data
- Null values in date and campaign_id column 
- Null and 'unknown' values in country_code column can be imputed by creating a lookup table with country codes per campaign id 
- campaign_id column values contains edge cases of some values with the decimal data type which needed to be casted to Integer to be consistent 

Issues identified with **channels** data
- Removed rows with Null values in campaign name and channel_5 columns 
- Removed all white spaces in campaign_name, channel_3, channel_4 channel_5 columns
- Dropped column campaign_period_budget_category since values are not always complete 
- Removed duplicates so that only unique values remain

Issues identified in the **leads_funnel** data
- Removed rows with unknown and null values in campaign_name and campaign_id columns 
- Casted values in campaign_id column to Integer datatype to be consistent
- Replaced null values in campaign_id and campaign_name columns with values from campaign lookup CTE
- Cleaned values in product column


For creating the dashboard in Looker Studio, I created 2 data marts based on the data that was cleaned in the tables above:
- **website_leads_kpis** : This table was used for reporting on leads that come directly to the website.
- **sales_funnel_kpis** : This table was used for reporting on lead progression through the sales funnel.

However, for the sake of simplicity, the data used in the dashboard is not loaded into an SQL server but is directly connected to a Google Sheet. All data cleaning steps were directly applied in the Google sheet.

The dashboard gives a high level overview of important metrics regarding Marketing and Sales activites such as:
- Customer Acquistion costs (Website related)
- Marketing Spends (Website related)
- Click Through Rate (Sales Funnel)
- Cost Per Click (Sales Funnel)
