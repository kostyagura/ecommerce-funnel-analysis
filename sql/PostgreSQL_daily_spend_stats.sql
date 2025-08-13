WITH facebook_data AS (
    SELECT 
        fbd.ad_date,
        fc.campaign_name,
        fad.adset_name,
        fbd.spend,
        'Facebook' AS platform
    FROM public.facebook_ads_basic_daily fbd
    JOIN public.facebook_campaign fc ON fbd.campaign_id = fc.campaign_id
    JOIN public.facebook_adset fad ON fbd.adset_id = fad.adset_id
),

google_data AS (
    SELECT 
        gad.ad_date,
        gad.campaign_name,
        gad.adset_name,
        gad.spend,
        'Google' AS platform
    FROM public.google_ads_basic_daily
)

SELECT 
    ad_date,
    platform,
    ROUND(AVG(spend), 2) AS avg_daily_spend,
    ROUND(MIN(spend), 2) AS min_daily_spend,
    ROUND(MAX(spend), 2) AS max_daily_spend
FROM (
    SELECT * FROM facebook_data
    UNION ALL
    SELECT * FROM google_data
) AS combined
GROUP BY ad_date, platform
ORDER BY ad_date, platform;
