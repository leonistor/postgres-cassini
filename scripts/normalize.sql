-- TEAM
DROP TABLE IF EXISTS teams;
SELECT DISTINCT(team) AS description INTO teams
FROM IMPORT.master_plan;
ALTER TABLE teams ADD id serial PRIMARY key;

-- SPASS TYPES
DROP TABLE IF EXISTS spass_types;
SELECT DISTINCT(spass_type) AS description INTO spass_types
FROM IMPORT.master_plan;
ALTER TABLE spass_types ADD id serial PRIMARY key;

-- TARGET
DROP TABLE IF EXISTS targets;
SELECT DISTINCT(target) AS description INTO targets
FROM IMPORT.master_plan;
ALTER TABLE targets ADD id serial PRIMARY key;

-- EVENT TYPES
DROP TABLE IF EXISTS event_types;
SELECT DISTINCT(library_definition) AS description INTO event_types
FROM IMPORT.master_plan;
ALTER TABLE event_types ADD id serial PRIMARY key;

--REQUESTS
DROP TABLE IF EXISTS requests;
SELECT DISTINCT(request_name) AS description INTO requests
FROM IMPORT.master_plan;
ALTER TABLE requests ADD id serial PRIMARY key;

--EVENTS
CREATE TABLE events(
    id            serial PRIMARY key,
    time_stamp    TIMESTAMP NOT NULL,
    title         VARCHAR(500),
    description   text,
    event_type_id INT REFERENCES event_types(id),
    target_id     INT REFERENCES targets(id),
    team_id       INT REFERENCES teams(id),
    request_id    INT REFERENCES requests(id),
    spass_type_id INT REFERENCES spass_types(id)
);

INSERT INTO
    events( time_stamp, title, description, event_type_id, target_id, team_id, request_id, spass_type_id )
    SELECT
        import.master_plan.start_time_utc::TIMESTAMP,
        import.master_plan.title,
        import.master_plan.description,
        event_types.id AS event_type_id,
        targets.id AS target_id,
        teams.id AS team_id,
        requests.id AS request_id,
        spass_types.id AS spass_type_id
    FROM
        import.master_plan
        LEFT JOIN event_types
            ON event_types.description = import.master_plan.library_definition
        LEFT JOIN targets
            ON targets.description = import.master_plan.target
        LEFT JOIN teams
            ON teams.description = import.master_plan.team
        LEFT JOIN requests
            ON requests.description = import.master_plan.request_name
        LEFT JOIN spass_types
            ON spass_types.description = import.master_plan.spass_type;
