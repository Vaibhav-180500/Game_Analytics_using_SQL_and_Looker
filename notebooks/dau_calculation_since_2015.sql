CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_dau_since_2015` AS
SELECT
  DATE(TIMESTAMP_SECONDS(auth_ts)) AS login_date,
  COUNT(DISTINCT uid) AS dau
FROM `gameanalytics-476310.game_analytics.auth_data`
WHERE auth_ts >= 1420070400  -- 2015-01-01 00:00:00 UTC
GROUP BY login_date
ORDER BY login_date;