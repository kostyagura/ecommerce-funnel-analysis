WITH user_sessions AS (
  SELECT
    user_pseudo_id || '-' || 
    CAST(
      (SELECT value.int_value 
       FROM UNNEST(event_params) 
       WHERE key = 'ga_session_id') AS STRING) AS user_session_id,
    DATE(TIMESTAMP_MICROS(event_timestamp)) AS event_date,
    traffic_source.source AS source,
    traffic_source.medium AS medium,
    traffic_source.name AS campaign,
    MAX(IF(event_name = 'add_to_cart', 1, 0)) AS is_add_to_cart,
    MAX(IF(event_name = 'begin_checkout', 1, 0)) AS is_begin_checkout,
    MAX(IF(event_name = 'purchase', 1, 0)) AS is_purchase
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN ('session_start', 'add_to_cart', 'begin_checkout', 'purchase')
  GROUP BY user_session_id, event_date, source, medium, campaign
)

SELECT event_date,
       source,
       medium,
       campaign,
       COUNT(*) AS user_sessions_count,
       SUM(is_add_to_cart) / COUNT(*) AS visit_to_cart,
       SUM(is_begin_checkout) / COUNT(*) AS visit_to_checkout,
       SUM(is_purchase) / COUNT(*) AS visit_to_purchase
FROM user_sessions
GROUP BY event_date, source, medium, campaign
ORDER BY event_date;