SELECT
    DISTINCT targets.description AS target,
    100.0 *
    -- events with this target
    (count(1) OVER (PARTITION BY targets.description))::numeric /
    -- all events
    (count(1) OVER ()::numeric) AS percent_of_mission
FROM
    events
    INNER JOIN targets ON targets.id = target_id
    ORDER BY percent_of_mission DESC;
