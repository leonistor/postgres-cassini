SELECT
  id,
  description
FROM
  targets
WHERE
  description ~* 'enceladus';
DROP VIEW if exists enceladus_events;
CREATE MATERIALIZED VIEW enceladus_events AS
SELECT
  events.id,
  events.title,
  events.description,
  events.time_stamp,
  events.time_stamp :: DATE AS date,
  event_types.description AS event,
  to_tsvector(concat(events.description, ' ', events.title)) AS search
FROM
  events
  INNER JOIN event_types ON event_types.id = events.event_type_id
WHERE
  target_id = 28
ORDER BY
  time_stamp;
SELECT
  id,
  title
FROM
  enceladus_events
WHERE
  search @ @ to_tsquery('closest');
  /* ~ */
  -- index on matview
  CREATE INDEX idx_event_search ON enceladus_events USING GIN(search);
