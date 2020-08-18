DROP MATERIALIZED VIEW if exists flyby_altitudes;
CREATE MATERIALIZED VIEW flyby_altitudes AS
SELECT
  sclk :: timestamp as time_stamp,
  date_part('year', sclk :: timestamp) as year,
  date_part('week', sclk :: timestamp) as week,
  alt_t :: NUMERIC(10, 3) as altitude
FROM
  import.inms
WHERE
  target = 'ENCELADUS'
  and alt_t IS NOT NULL;
