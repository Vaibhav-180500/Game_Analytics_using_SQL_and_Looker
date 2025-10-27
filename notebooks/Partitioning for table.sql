-- Partitioning for reg_data
/* CREATE TABLE `gameanalytics-476310.game_analytics.reg_data` (
  
  reg_ts INT64,  -- Unix seconds
  uid INT64
  
)
PARTITION BY RANGE_BUCKET(
  reg_ts,
  GENERATE_ARRAY(883612800, 1609459200, 31536000)  -- 1998-01-01 .. 2021-01-01 step 1 year (365d)
)
CLUSTER BY uid;
*/


-- Partitioning for auth_data
/*
CREATE TABLE `gameanalytics-476310.game_analytics.auth_data` (
  
  auth_ts INT64,  -- Unix seconds
  uid INT64
  
)
PARTITION BY RANGE_BUCKET(
  auth_ts,
  GENERATE_ARRAY(883612800, 1609459200, 31536000)  -- 1998-01-01 .. 2021-01-01 step 1 year (365d)
)
CLUSTER BY uid;
*/