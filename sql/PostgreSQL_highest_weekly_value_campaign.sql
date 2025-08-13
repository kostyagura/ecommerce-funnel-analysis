WITH base_data AS (
    SELECT fbd.ad_date,
           fc.campaign_name,
           fad.adset_name,
           fbd.value
    FROM public.facebook_ads_basic_daily fbd
    JOIN public.facebook_campaign fc ON fbd.campaign_id = fc.campaign_id
    JOIN public.facebook_adset fad ON fbd.adset_id = fad.adset_id

    UNION ALL

    SELECT gad.ad_date,
           gad.campaign_name,
           gad.adset_name,
           gad.value
    FROM public.google_ads_basic_daily gad
),

weekly_aggregated AS (
    SELECT campaign_name,
           DATE_TRUNC('week', ad_date)::date AS week_start,
           SUM(value) AS total_value
    FROM base_data
    WHERE value IS NOT NULL
    GROUP BY campaign_name, DATE_TRUNC('week', ad_date)
)

SELECT campaign_name,
       week_start AS week,
       ROUND(total_value, 2) AS total_value
FROM weekly_aggregated
ORDER BY total_value DESC
LIMIT 1;



