SELECT
  TIMESTAMP_MICROS(event_timestamp) AS event_timestamp,
  user_pseudo_id,
  (
    SELECT ep.value.int_value
    FROM UNNEST(event_params) ep
    WHERE ep.key = "ga_session_id"
  ) AS session_id,
  event_name,
  geo.country AS country,
  device.category AS device_category,
  traffic_source.source AS source,
  traffic_source.medium AS medium,
  traffic_source.name AS campaign
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events*`
WHERE
  event_name IN (
    'session_start',
    'view_item',
    'add_to_cart',
    'begin_checkout',
    'add_shipping_info',
    'add_payment_info',
    'purchase'
  )
  AND event_date BETWEEN '20210101' AND '20211231'