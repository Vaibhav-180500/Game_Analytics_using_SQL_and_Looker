CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_engagement_span` AS

WITH life_span AS (
  SELECT
    reg.uid,
    DATE(TIMESTAMP_SECONDS(reg.reg_ts)) AS reg_date,
    -- only count logins on/after the user's reg_date
    MAX(DATE(TIMESTAMP_SECONDS(auth.auth_ts))) AS last_login
  FROM `gameanalytics-476310.game_analytics.reg_data`   reg
  LEFT JOIN `gameanalytics-476310.game_analytics.auth_data` auth
    ON reg.uid = auth.uid
   AND auth.auth_ts >= reg.reg_ts
  WHERE reg.reg_ts >= 1420070400  -- 2015-01-01 UTC
  GROUP BY reg.uid, reg_date
),
span_info AS (
  SELECT
    uid,
    reg_date,
    last_login,
    DATE_DIFF(IFNULL(last_login, reg_date), reg_date, DAY) AS life_span_days
  FROM life_span
)
SELECT 'avg_lifespan'  AS measure_name, ROUND(AVG(life_span_days)) AS days FROM span_info
UNION ALL
SELECT 'max_lifespan', MAX(life_span_days) FROM span_info
UNION ALL
SELECT 'min_lifespan', MIN(life_span_days) FROM span_info
UNION ALL
SELECT 'median',       APPROX_QUANTILES(life_span_days, 2)[OFFSET(1)]  FROM span_info
UNION ALL
SELECT '90th perc',    APPROX_QUANTILES(life_span_days, 100)[OFFSET(90)] FROM span_info;