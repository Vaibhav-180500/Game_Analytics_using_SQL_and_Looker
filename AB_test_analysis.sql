CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_ab_test_analysis` AS

SELECT 
  testgroup,
  COUNT(user_id) AS users,
  COUNT(DISTINCT IF(revenue >0, user_id, NULL)) AS payers,
  SUM(revenue) AS total_revenue,
  SAFE_DIVIDE(SUM(revenue), COUNT(DISTINCT user_id)) AS avg_rev

FROM `gameanalytics-476310.game_analytics.ab_test`
GROUP BY testgroup
ORDER BY testgroup