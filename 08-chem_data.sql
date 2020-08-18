CREATE TABLE chem_data (
  name TEXT,
  formula VARCHAR(10),
  molecular_weight INTEGER,
  peak INTEGER,
  sensitivity NUMERIC
);
COPY chem_data
FROM
  '/home/leo/src/postgres/curious_data/data/INMS/chem_data.csv' WITH DELIMITER ',' HEADER CSV;
