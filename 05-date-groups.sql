-- search dates to download CSVs
SELECT
  date_part('year', date),
  to_char(time_stamp, 'DDD')
FROM
  enceladus_events
WHERE
  event LIKE '%closest%';
