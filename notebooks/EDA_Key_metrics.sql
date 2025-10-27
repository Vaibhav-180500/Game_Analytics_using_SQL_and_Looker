--CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_dau_since_2015` AS

SELECT 'total_registered_users' AS measure_name,
       CAST(COUNT(DISTINCT uid) AS NUMERIC) AS measure_value
FROM `gameanalytics-476310.game_analytics.reg_data`

UNION ALL

SELECT 'total_registeration_since_2015' AS measure_name,
       CAST(COUNT(DISTINCT uid) AS NUMERIC) AS measure_value
FROM `gameanalytics-476310.game_analytics.reg_data`
WHERE reg_ts >= 1420070400

UNION ALL

SELECT 'total_users_(abtest)',
       CAST(COUNT(DISTINCT user_id) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`

UNION ALL
SELECT 'total_users_not_in_abtest',
       CAST(COUNT(*) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.reg_data` reg
LEFT JOIN `gameanalytics-476310.game_analytics.ab_test` ab
  ON reg.uid = ab.user_id
WHERE ab.user_id IS NULL

UNION ALL
SELECT 'total_paying_users_(abtest)',
       CAST(COUNT(DISTINCT user_id) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE revenue > 0

UNION ALL
SELECT 'min_amt_spent_(abtest)',
       CAST(MIN(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE revenue > 0

UNION ALL
SELECT 'max_amt_spent_(abtest)',
       CAST(MAX(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE revenue > 0

UNION ALL
SELECT 'total_revenue_(abtest)',
       CAST(SUM(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`

UNION ALL
SELECT 'total_revenue_(group_a)',
       CAST(SUM(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE testgroup = 'a'

UNION ALL
SELECT 'total_revenue_(group_b)',
       CAST(SUM(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE testgroup = 'b'

UNION ALL
SELECT 'avg_revenue_for_paying_users_(abtest)',
       CAST(AVG(revenue) AS NUMERIC)
FROM `gameanalytics-476310.game_analytics.ab_test`
WHERE revenue > 0;
