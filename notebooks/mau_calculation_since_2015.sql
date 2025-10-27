CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_mau_since_2015` AS
WITH dates AS (
  SELECT DISTINCT DATE(TIMESTAMP_SECONDS(auth_ts)) AS login_date
  FROM `gameanalytics-476310.game_analytics.auth_data`
  WHERE TIMESTAMP_SECONDS(auth_ts) >= TIMESTAMP '2015-01-01'
  )


SELECT 
  d.login_date AS login_date,
  COUNT(DISTINCT a.uid) AS MAU,
  COUNT(DISTINCT DATE(TIMESTAMP_SECONDS(a.auth_ts))) AS trailing_days
FROM dates d
LEFT JOIN `gameanalytics-476310.game_analytics.auth_data` a
  ON DATE(TIMESTAMP_SECONDS(a.auth_ts)) <= d.login_date
  AND DATE(TIMESTAMP_SECONDS(a.auth_ts)) > DATE_ADD(d.login_date, INTERVAL -30 DAY)
GROUP BY d.login_date
ORDER BY d.login_date