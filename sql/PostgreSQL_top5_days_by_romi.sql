WITH fb_daily AS (
    SELECT ad_date,
           SUM(spend) AS spend,
           SUM(value) AS value
    FROM public.facebook_ads_basic_daily
    WHERE spend IS NOT NULL AND value IS NOT NULL
    GROUP BY ad_date
),
google_daily AS (
    SELECT ad_date,
           SUM(spend) AS spend,
           SUM(value) AS value
    FROM public.google_ads_basic_daily
    WHERE spend IS NOT NULL AND value IS NOT NULL
    GROUP BY ad_date
),
combined_daily AS (
    SELECT ad_date, 
    	   spend, 
    	   value FROM fb_daily
    UNION ALL
    SELECT ad_date, 
    	   spend, 
    	   value FROM google_daily
),
aggregated AS (
    SELECT ad_date,
           SUM(spend) AS total_spend,
           SUM(value) AS total_value
    FROM combined_daily
    GROUP BY ad_date
)
SELECT 
    ad_date,
    ROUND(total_value / NULLIF(total_spend, 0), 2) AS romi
FROM aggregated
WHERE total_spend > 0
ORDER BY romi DESC
LIMIT 5;