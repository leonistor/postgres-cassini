ALTER TABLE
  flybys RENAME TO flybys_trigo;
CREATE TABLE flybys (
    id       INT PRIMARY KEY,
    name     TEXT NOT NULL,
    date     DATE NOT NULL,
    altitude NUMERIC(7, 1),
    speed    NUMERIC(7, 1)
  );

COPY flybys FROM '/home/leo/src/postgres/curious_data/data/jpl_flybys.csv'
    DELIMITER ',' HEADER CSV;
