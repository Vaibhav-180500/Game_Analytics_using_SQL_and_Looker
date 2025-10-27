WITH user_login_counts AS (
  SELECT
    user_id,
    SUM(revenue) AS total_revenue
  FROM `gameanalytics-476310.game_analytics.ab_test`
  GROUP BY user_id
)
, bucket AS(
  SELECT
    CASE
      WHEN total_revenue = 0 THEN 'Non-paying'
      WHEN total_revenue BETWEEN 1 AND 499 THEN 'Low spend (1 to 499)'
      WHEN total_revenue BETWEEN 500 AND 1999 THEN 'Medium spend (500 to 1,999)'
      WHEN total_revenue BETWEEN 2000 AND 9999 THEN 'High spend (2,000 to 9,999)'
      WHEN total_revenue BETWEEN 10000 AND 19999 THEN 'Very high spend (10,000 to 19,999)'
      ELSE 'Ultra spenders (20,000+)' 
      END AS revenue_bucket,

    -- Business meaning for easier interpretation
    CASE
      WHEN total_revenue = 0 THEN 'Tried the game but did not convert'
      WHEN total_revenue BETWEEN 1 AND 499 THEN 'Impulse buyers, usually 1 small purchase'
      WHEN total_revenue BETWEEN 500 AND 1999 THEN 'Customers with decent engagement'
      WHEN total_revenue BETWEEN 2000 AND 9999 THEN 'Strong value players'
      WHEN total_revenue BETWEEN 10000 AND 19999 THEN 'VIP tier potential'
      ELSE 'Whales driving revenue' 
      END AS Player_Meaning,

    user_id,
    total_revenue

  FROM user_login_counts
)

, totals AS (
    SELECT COUNT(*) AS total_users,
         SUM(total_revenue) AS total_revenue_sum
  FROM bucket
)

SELECT 
  revenue_bucket,
  Player_Meaning,
  COUNT(*) AS user_count,
  ROUND(COUNT(*) / total_users, 3) AS pct_total_users,
  ROUND(SUM(total_revenue) / total_revenue_sum, 3) AS pct_total_revenue

FROM bucket, totals
GROUP BY 1,2, total_users, total_revenue_sum
ORDER BY 1







