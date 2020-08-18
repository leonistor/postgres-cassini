-- make room for new stuff
ALTER TABLE
  flybys
ADD
  speed_kms numeric(10, 3),
ADD
  target_altitude numeric(10, 3),
ADD
  transit_distance numeric(10, 3);

UPDATE
  flybys
SET
  target_altitude = (altitude + 252) / sind(73) - 252;

UPDATE
  flybys
SET
  transit_distance = (target_altitude + 252) * sind(17) * 2;
