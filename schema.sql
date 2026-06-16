-- schema.sql : create tables for the campus smoking-behaviour survey
DROP TABLE IF EXISTS responses;
DROP TABLE IF EXISTS stress_levels;

CREATE TABLE responses (
    respondent_id        INTEGER PRIMARY KEY,
    gender               TEXT,
    study_year           TEXT,
    is_smoker            TEXT,    -- Yes / No
    started_at_university TEXT,   -- Yes / No / N/A
    stress_level         TEXT,    -- Low / Medium / High
    peer_network_size    TEXT,    -- Small / Medium / Large
    primary_reason       TEXT
);

CREATE TABLE stress_levels (
    stress_level TEXT PRIMARY KEY,
    description  TEXT,
    sort_order   INTEGER
);
