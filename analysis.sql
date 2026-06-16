-- analysis.sql : key questions answered with SQL
-- Run after loading data (see README).

-- Q1. How many responses, and what is the overall smoking rate?
SELECT COUNT(*) AS total_responses,
       SUM(CASE WHEN is_smoker = 'Yes' THEN 1 ELSE 0 END) AS smokers,
       ROUND(100.0 * SUM(CASE WHEN is_smoker = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS smoker_pct
FROM responses;

-- Q2. HEADLINE: among students who STARTED smoking at university,
--     what share cite each primary reason? (peer social norms expected ~60%)
SELECT primary_reason,
       COUNT(*) AS n,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM responses
WHERE started_at_university = 'Yes'
GROUP BY primary_reason
ORDER BY n DESC;

-- Q3. Smoking rate by stress level (JOIN to the lookup table for ordering + labels)
SELECT s.stress_level,
       s.description,
       COUNT(*) AS respondents,
       SUM(CASE WHEN r.is_smoker = 'Yes' THEN 1 ELSE 0 END) AS smokers,
       ROUND(100.0 * SUM(CASE WHEN r.is_smoker = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS smoker_pct
FROM responses r
JOIN stress_levels s ON r.stress_level = s.stress_level
GROUP BY s.stress_level, s.description, s.sort_order
ORDER BY s.sort_order;

-- Q4. Cross-tab: smoking rate by peer-network size
SELECT peer_network_size,
       COUNT(*) AS respondents,
       SUM(CASE WHEN is_smoker = 'Yes' THEN 1 ELSE 0 END) AS smokers,
       ROUND(100.0 * SUM(CASE WHEN is_smoker = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS smoker_pct
FROM responses
GROUP BY peer_network_size
ORDER BY CASE peer_network_size WHEN 'Small' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;
