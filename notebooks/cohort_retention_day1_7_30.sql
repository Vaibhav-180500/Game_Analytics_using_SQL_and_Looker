WITH registration AS (
  SELECT 
    uid, 
    DATE(TIMESTAMP_SECONDS(reg_ts)) AS reg_date
  
  FROM `gameanalytics-476310.game_analytics.reg_data`
  
  WHERE reg_ts >= 1420070400  -- 2015-01-01 UTC
  
  GROUP BY ALL
  
  ORDER BY 2
)

, cohort AS(
  SELECT 
    r.uid,
    r.reg_date,
    m.max_login_date,
    DATE_ADD(r.reg_date, INTERVAL 1 DAY) AS day_1,
    DATE_ADD(r.reg_date, INTERVAL 7 DAY) AS day_7,
    DATE_ADD(r.reg_date, INTERVAL 30 DAY) AS day_30
  FROM registration r
  CROSS JOIN
  (SELECT MAX(DATE(TIMESTAMP_SECONDS(auth_ts))) AS max_login_date
  FROM `gameanalytics-476310.game_analytics.auth_data` ) m
)

, retention AS(
  SELECT
    c.reg_date,
    COUNT(DISTINCT c.uid) AS total_installs,
    SUM(CASE
      WHEN c.day_1 > c.max_login_date THEN NULL
      WHEN c.day_1 = DATE(TIMESTAMP_SECONDS(lg.auth_ts)) THEN 1 ELSE 0 END) AS day_1_retained,
    SUM(CASE
      WHEN c.day_7 > c.max_login_date THEN NULL
      WHEN c.day_7 = DATE(TIMESTAMP_SECONDS(lg.auth_ts)) THEN 1 ELSE 0 END) AS day_7_retained,
    SUM(CASE
      WHEN c.day_30 > c.max_login_date THEN NULL
      WHEN c.day_30 = DATE(TIMESTAMP_SECONDS(lg.auth_ts)) THEN 1 ELSE 0 END) AS day_30_retained

  FROM cohort c

  LEFT JOIN `gameanalytics-476310.game_analytics.auth_data` lg
    ON c.uid = lg.uid
    AND DATE(TIMESTAMP_SECONDS(lg.auth_ts))>c.reg_date
    AND DATE(TIMESTAMP_SECONDS(lg.auth_ts))<=DATE_ADD(c.reg_date, INTERVAL 30 DAY)

  GROUP BY c.reg_date
  ORDER BY c.reg_date
)

SELECT 
  *,
  SAFE_DIVIDE(day_1_retained, total_installs) AS day_1_retention_pct,
  SAFE_DIVIDE(day_7_retained, total_installs) AS day_7_retention_pct,
  SAFE_DIVIDE(day_30_retained, total_installs) AS day_30_retention_pct

FROM retention
