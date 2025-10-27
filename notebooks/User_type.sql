
CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_user_type` AS
WITH user_login_counts AS (
  SELECT
    uid,
    COUNT(*) AS login_count
  FROM `gameanalytics-476310.game_analytics.auth_data`
  GROUP BY uid
)

SELECT
  CASE
    WHEN login_count BETWEEN 1 AND 2 THEN '1-2'
    WHEN login_count BETWEEN 3 AND 5 THEN '3-5'
    WHEN login_count BETWEEN 6 AND 10 THEN '6-10'
    WHEN login_count BETWEEN 11 AND 20 THEN '11-20'
    WHEN login_count BETWEEN 21 AND 50 THEN '21-50'
    WHEN login_count BETWEEN 51 AND 100 THEN '51-100'
    WHEN login_count BETWEEN 101 AND 250 THEN '101-250'
    WHEN login_count BETWEEN 251 AND 500 THEN '251-500'
    ELSE '501+'
  END AS login_count_bucket,

  -- Business meaning for easier interpretation
  CASE
    WHEN login_count BETWEEN 1 AND 2 THEN 'One-timers / Almost churned'
    WHEN login_count BETWEEN 3 AND 5 THEN 'New adopters'
    WHEN login_count BETWEEN 6 AND 10 THEN 'Early retained users'
    WHEN login_count BETWEEN 11 AND 20 THEN 'Casual regulars'
    WHEN login_count BETWEEN 21 AND 50 THEN 'Engaged users'
    WHEN login_count BETWEEN 51 AND 100 THEN 'Power users'
    WHEN login_count BETWEEN 101 AND 250 THEN 'Super users'
    WHEN login_count BETWEEN 251 AND 500 THEN 'Heavy users'
    ELSE 'Ultra-core users'
  END AS business_name,

  COUNT(*) AS num_users

FROM user_login_counts
GROUP BY login_count_bucket, business_name
ORDER BY
  CASE login_count_bucket
    WHEN '1-2' THEN 1
    WHEN '3-5' THEN 2
    WHEN '6-10' THEN 3
    WHEN '11-20' THEN 4
    WHEN '21-50' THEN 5
    WHEN '51-100' THEN 6
    WHEN '101-250' THEN 7
    WHEN '251-500' THEN 8
    ELSE 9
  END;
