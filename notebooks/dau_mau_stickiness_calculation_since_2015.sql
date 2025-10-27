CREATE OR REPLACE VIEW `gameanalytics-476310.game_analytics.vw_dau_mau_stickiness_since_2015` AS
SELECT 
  dau.login_date,
  dau.dau,
  mau.MAU,
  CASE 
    WHEN mau.MAU > 0 THEN SAFE_DIVIDE(dau.dau, mau.MAU) ELSE 0 END AS stickiness


FROM `gameanalytics-476310.game_analytics.vw_dau_since_2015` dau
JOIN `gameanalytics-476310.game_analytics.vw_mau_since_2015` mau 
  ON dau.login_date=mau.login_date
GROUP BY ALL
ORDER BY 1