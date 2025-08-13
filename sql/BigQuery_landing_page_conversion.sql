WITH session_starts AS (
  SELECT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = "ga_session_id"
    ) AS session_id,
    REGEXP_EXTRACT(
      (SELECT value.string_value
       FROM UNNEST(event_params)
       WHERE key = "page_location"),
      r'^https?://[^/]+(/[^?#]*)'
    ) AS page_path
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events*`
  WHERE event_name = 'session_start'
    AND event_date BETWEEN '20200101' AND '20201231'
),

purchases AS (
  SELECT DISTINCT
    user_pseudo_id,
    (
      SELECT value.int_value
      FROM UNNEST(event_params)
      WHERE key = "ga_session_id"
    ) AS session_id
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events*`
  WHERE event_name = 'purchase'
    AND event_date BETWEEN '20200101' AND '20201231'
),

combined AS (
  SELECT
    ss.page_path,
    ss.user_pseudo_id,
    ss.session_id,
    IF(p.session_id IS NOT NULL, 1, 0) AS is_purchase
  FROM session_starts ss
  LEFT JOIN purchases p
    ON ss.user_pseudo_id = p.user_pseudo_id
    AND ss.session_id = p.session_id
)

SELECT
  page_path,
  COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(session_id AS STRING))) AS unique_sessions,
  SUM(is_purchase) AS purchases,
  ROUND(SAFE_DIVIDE(SUM(is_purchase), COUNT(DISTINCT CONCAT(user_pseudo_id, CAST(session_id AS STRING)))), 4) AS conversion_rate
FROM combined
WHERE page_path IS NOT NULL
GROUP BY page_path
ORDER BY conversion_rate DESC
