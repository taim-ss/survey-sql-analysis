# Campus Smoking-Behaviour Survey - SQL Analysis

SQL analysis of a hypothesis-driven campus survey on student smoking behaviour
(83 respondents). Built to practise real analytical SQL: aggregation, conditional
counting, window functions, cross-tabulation, and a JOIN to a lookup table.

> **Data note:** `data/survey_responses.csv` is a **sample dataset** that reproduces
> the structure and the headline finding of my campus research project. To regenerate
> the exact figures from the real study, replace this file with the real export
> (same columns) and re-run the steps below.

## Key finding
Among students who **started smoking at university**, **60% cited peer social norms**
- not academic stress - as the primary driver of smoking initiation. See `RESULTS.md` for the full output.

## Data
`data/survey_responses.csv` - one row per respondent:

| column | meaning |
|---|---|
| respondent_id | unique id |
| gender, study_year | demographics |
| is_smoker | Yes / No |
| started_at_university | did they start smoking after enrolling? |
| stress_level | Low / Medium / High |
| peer_network_size | Small / Medium / Large |
| primary_reason | self-reported main reason |

`data/stress_levels.csv` - a small lookup table (used to demonstrate a JOIN).

## How to run (no install needed - uses SQLite)
```bash
# 1. create the database and tables
sqlite3 survey.db < schema.sql

# 2. load the CSVs
sqlite3 survey.db <<'SQL'
.mode csv
.import --skip 1 data/survey_responses.csv responses
.import --skip 1 data/stress_levels.csv stress_levels
SQL

# 3. run the analysis
sqlite3 survey.db < analysis.sql
```
Or open `survey.db` in **DB Browser for SQLite** (free GUI) and run `analysis.sql`.

## Skills demonstrated
`SELECT` / `WHERE` / `GROUP BY` / `ORDER BY`, conditional aggregation
(`SUM(CASE WHEN ...)`), window function (`SUM(...) OVER ()`), `JOIN`, and
cross-tabulation for survey analysis.
