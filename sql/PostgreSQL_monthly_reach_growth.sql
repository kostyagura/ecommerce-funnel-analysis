WITH base_data AS (
    SELECT fbd.ad_date,
           fc.campaign_name,
           fbd.reach
    FROM public.facebook_ads_basic_daily fbd
    JOIN public.facebook_campaign fc ON fbd.campaign_id = fc.campaign_id

    UNION ALL

    SELECT gad.ad_date,
           gad.campaign_name,
           gad.reach
    FROM public.google_ads_basic_daily gad
),

monthly_reach AS (
    SELECT DATE_TRUNC('month', ad_date)::date AS ad_month,
           campaign_name,
           SUM(reach) AS monthly_reach
    FROM base_data
    WHERE reach IS NOT NULL
    GROUP BY ad_month, campaign_name
),

reach_with_diff AS (
    SELECT campaign_name,
           ad_month,
           monthly_reach,
           LAG(monthly_reach) 
           OVER (
            PARTITION BY campaign_name
            ORDER BY ad_month
         ) AS previous_month_reach
    FROM monthly_reach
),

reach_growth_calc AS (
    SELECT campaign_name,
           ad_month,
           monthly_reach,
           previous_month_reach,
           monthly_reach - previous_month_reach AS reach_growth
    FROM reach_with_diff
    WHERE previous_month_reach IS NOT NULL
)

SELECT campaign_name,
       ad_month,
       ROUND(monthly_reach) AS monthly_reach,
       ROUND(previous_month_reach) AS previous_month_reach,
       ROUND(reach_growth) AS reach_growth
FROM reach_growth_calc
ORDER BY reach_growth DESC
LIMIT 1;





