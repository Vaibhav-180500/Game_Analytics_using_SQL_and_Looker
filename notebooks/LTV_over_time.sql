
CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_LTV_over_time` AS
WITH ltv AS (
  SELECT 
    reg.uid,
    DATE(TIMESTAMP_SECONDS(reg.reg_ts)) AS reg_date,
    SUM(ab.revenue) AS LTV

  FROM `gameanalytics-476310.game_analytics.reg_data` reg
  INNER JOIN `gameanalytics-476310.game_analytics.ab_test` ab 
    ON reg.uid = ab.user_id
  GROUP BY 1,2
)

SELECT 
  DATE_TRUNC(ltv.reg_date, MONTH) AS year_month,
  SUM(ltv.LTV) AS Total_LTV,
  AVG(ltv.LTV) AS Avg_LTV
FROM ltv
GROUP BY 1
