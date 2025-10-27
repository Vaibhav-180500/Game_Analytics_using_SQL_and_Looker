

-- DECLARE daysToChurn INT64 DEFAULT 14;

CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_churn_daily` AS

WITH daily_logins AS (
  SELECT
    uid,
    DATE(TIMESTAMP_SECONDS(auth_ts)) AS login_date,
    MAX(DATE(TIMESTAMP_SECONDS(auth_ts))) OVER() AS max_login_date_over_all


  FROM `gameanalytics-476310.game_analytics.auth_data`
  WHERE auth_ts >= 1420070400  -- 2015-01-01 UTC
)

, churners AS(
  SELECT 
    d.uid,
    d.max_login_date_over_all,
    MAX(d.login_date) AS max_login_date

  FROM daily_logins d
  GROUP BY 1,2
)

, churn AS(
  SELECT 
    uid,
    max_login_date_over_all,
    max_login_date,
    DATE_ADD(max_login_date, INTERVAL 14 DAY) AS churn_date

  FROM churners
)

SELECT 
  churn_date,
  COUNT(DISTINCT uid) AS churners
FROM churn
WHERE churn_date <= max_login_date_over_all
GROUP BY churn_date
ORDER BY churn_date


