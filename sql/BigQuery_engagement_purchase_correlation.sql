WITH base_events AS (
  SELECT
    user_pseudo_id,
    (SELECT value.int_value
     FROM UNNEST(event_params)
     WHERE key = "ga_session_id") AS session_id,
     MAX(
      CASE
        WHEN (SELECT value.string_value FROM UNNEST(event_params) WHERE key = "session_engaged") = '1' THEN 1
        ELSE 0
      END
    ) AS session_engaged,
    SUM(
      COALESCE((SELECT value.int_value FROM UNNEST(event_params) WHERE key = "engagement_time_msec"), 0)
    ) AS engagement_time_msec,
    MAX(CASE WHEN event_name = "purchase" THEN 1 ELSE 0 END) AS purchase_made

  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events*`
  WHERE
    (SELECT value.int_value FROM UNNEST(event_params) WHERE key = "ga_session_id") IS NOT NULL
  GROUP BY
    user_pseudo_id,
    session_id
),

correlation_calc AS (
  SELECT
    CORR(CAST(session_engaged AS FLOAT64), CAST(purchase_made AS FLOAT64)) AS corr_engaged_vs_purchase,
    CORR(CAST(engagement_time_msec AS FLOAT64), CAST(purchase_made AS FLOAT64)) AS corr_time_vs_purchase
  FROM
    base_events
)

SELECT * FROM correlation_calc;