CREATE TABLE fixed_flybys AS WITH mins AS (
  SELECT
    min(altitude) AS nadir,
    YEAR,
    WEEK
  FROM
    time_altitudes
  GROUP BY
    YEAR,
    WEEK
  ORDER BY
    YEAR,
    WEEK
),
min_times AS (
  SELECT
    mins.*,
    min(time_stamp) AS low_time,
    min(time_stamp) + interval '20 seconds' AS window_end,
    min(time_stamp) - interval '20 seconds' AS window_start
  FROM
    mins
    INNER JOIN time_altitudes ta ON mins.year = ta.year
    AND mins.week = ta.week
    AND mins.nadir = ta.altitude
  GROUP BY
    mins.week,
    mins.year,
    mins.nadir
),
fixed_flybys AS (
  SELECT
    f.id,
    f.name,
    f.date,
    f.altitude,
    f.speed,
    mt.nadir,
    mt.year,
    mt.week,
    mt.low_time,
    mt.window_start,
    mt.window_end
  FROM
    flybys f
    INNER JOIN min_times mt ON date_part('year', f.date) = mt.year
    AND date_part('week', f.date) = mt.week
)
SELECT
  *
FROM
  fixed_flybys;
