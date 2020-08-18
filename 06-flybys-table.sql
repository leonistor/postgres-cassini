DROP TABLE IF EXISTS flybys;

--redone CTE
WITH lows_by_week AS (
    select year,
        week,
        min(altitude) AS altitude
    from flyby_altitudes
    group BY
        year,
        week
),
nadirs AS (
    select low_time (altitude, year, week) AS time_stamp,
      altitude
    from lows_by_week)
-- exec the CTE, pushing results into flybys
SELECT
    nadirs.*,
    -- set initial vals to null
    NULL::varchar AS name,
    NULL::timestamptz AS start_time,
    NULL::timestamptz AS end_time
    -- push to a new table
    INTO flybys
FROM
    nadirs;

-- add a primary key
ALTER TABLE flybys
    ADD COLUMN id serial PRIMARY KEY;

-- using the key, create
-- the name using the new id
-- || concatenates strings
-- and also coerces to string

UPDATE
    flybys
SET
    name = 'E - '|| id - 1;
