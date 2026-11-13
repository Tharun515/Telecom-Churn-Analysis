CREATE TABLE telecom_data (
    country TEXT,
    state TEXT,
    year INTEGER,
    month DATE,
    telecom_circle_name TEXT,
    service_provider TEXT,
    wireless_subscribers NUMERIC,
    vlr_peak_day NUMERIC,
    wireline_subscribers NUMERIC
);

select * from telecom_data;

SELECT COUNT(*) AS total_rows
FROM telecom_data;

SELECT * FROM telecom_data
LIMIT 10;

SELECT 
	COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE country IS NULL) AS misssing_country,
	COUNT(*) FILTER (WHERE state IS NULL) AS missing_state,
    COUNT(*) FILTER (WHERE state IS NULL) AS missing_state,
    COUNT(*) FILTER (WHERE year IS NULL) AS missing_year,
    COUNT(*) FILTER (WHERE month IS NULL) AS missing_month,
    COUNT(*) FILTER (WHERE telecom_circle_name IS NULL) AS missing_circle,
    COUNT(*) FILTER (WHERE service_provider IS NULL) AS missing_provider,
    COUNT(*) FILTER (WHERE wireless_subscribers IS NULL) AS missing_wireless,
    COUNT(*) FILTER (WHERE vlr_peak_day IS NULL) AS missing_vlr,
    COUNT(*) FILTER (WHERE wireline_subscribers IS NULL) AS missing_wireline
FROM telecom_data;

SELECT
    country,
    state,
    year,
    month,
    telecom_circle_name,
    service_provider,
    COUNT(*) AS duplicate_count
FROM telecom_data
GROUP BY
    country,
    state,
    year,
    month,
    telecom_circle_name,
    service_provider
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT
    service_provider,
    COUNT(*) AS record_count
FROM telecom_data
GROUP BY service_provider
ORDER BY record_count DESC;

SELECT
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data;

/*Which telecom service providers account for the largest subscriber volumes in the dataset?*/
SELECT
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY service_provider
ORDER BY total_wireless_subscribers DESC;

/*How does the telecom subscriber base change month by month?*/

SELECT
    year,
    month,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY year, month
ORDER BY year, month;

/*Overall Subscriber Landscape*/
SELECT
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data;

/*Provider Distribution*/
SELECT
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY service_provider
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/*State-Level Subscriber Distribution*/
SELECT
    state,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY state
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/*Which telecom circles have the highest wireless subscriber activity?*/
SELECT
    telecom_circle_name,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY telecom_circle_name
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/*How does cumulative wireless subscriber activity change across the months in the dataset?*/
SELECT
    month,
    SUM(wireless_subscribers) AS total_wireless_subscribers
FROM telecom_data
GROUP BY month
ORDER BY month;

/*How much did the reported wireless subscriber total change compared with the previous month?*/
SELECT
    month,
    total_wireless_subscribers,
    LAG(total_wireless_subscribers) OVER (
        ORDER BY month
    ) AS previous_month_subscribers,
    total_wireless_subscribers
        - LAG(total_wireless_subscribers) OVER (
            ORDER BY month
        ) AS monthly_change
FROM (
    SELECT
        month,
        SUM(wireless_subscribers) AS total_wireless_subscribers
    FROM telecom_data
    GROUP BY month
) AS monthly_data
ORDER BY month;

/*How does each service provider's wireless subscriber activity change over time?*/
SELECT
    service_provider,
    month,
    SUM(wireless_subscribers) AS wireless_subscribers,
    LAG(SUM(wireless_subscribers)) OVER (
        PARTITION BY service_provider
        ORDER BY month
    ) AS previous_month_subscribers,
    SUM(wireless_subscribers)
        - LAG(SUM(wireless_subscribers)) OVER (
            PARTITION BY service_provider
            ORDER BY month
        ) AS monthly_change
FROM telecom_data
GROUP BY
    service_provider,
    month
ORDER BY
    service_provider,
    month;

/*Within each telecom circle, which service providers have the highest wireless subscriber volume?*/
SELECT
    telecom_circle_name,
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    RANK() OVER (
        PARTITION BY telecom_circle_name
        ORDER BY SUM(wireless_subscribers) DESC NULLS LAST
    ) AS provider_rank
FROM telecom_data
GROUP BY
    telecom_circle_name,
    service_provider
ORDER BY
    telecom_circle_name,
    provider_rank;

/*How does wireless subscriber activity compare with wireline subscriber activity across states?*/
SELECT
    state,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    SUM(wireless_subscribers) / NULLIF(SUM(wireline_subscribers), 0)
        AS wireless_to_wireline_ratio
FROM telecom_data
GROUP BY state
ORDER BY wireless_to_wireline_ratio DESC NULLS LAST;

/*How does VLR activity compare with the wireless subscriber base across states?*/
SELECT
    state,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data
GROUP BY state
ORDER BY avg_vlr_peak_day DESC NULLS LAST;

/*Which provider–state combinations have the highest reported wireless subscriber volumes?*/
SELECT
    state,
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers
FROM telecom_data
GROUP BY
    state,
    service_provider
ORDER BY
    total_wireless_subscribers DESC NULLS LAST;

/*Which provider experienced the largest month-over-month increase or decrease in reported wireless subscriber activity?*/
WITH provider_monthly AS (
    SELECT
        service_provider,
        month,
        SUM(wireless_subscribers) AS wireless_subscribers
    FROM telecom_data
    GROUP BY
        service_provider,
        month
),
provider_changes AS (
    SELECT
        service_provider,
        month,
        wireless_subscribers,
        LAG(wireless_subscribers) OVER (
            PARTITION BY service_provider
            ORDER BY month
        ) AS previous_month_subscribers
    FROM provider_monthly
)
SELECT
    service_provider,
    month,
    wireless_subscribers,
    previous_month_subscribers,
    wireless_subscribers - previous_month_subscribers AS monthly_change
FROM provider_changes
WHERE previous_month_subscribers IS NOT NULL
ORDER BY ABS(wireless_subscribers - previous_month_subscribers) DESC
LIMIT 20;

/* View 1*/
CREATE OR REPLACE VIEW vw_monthly_subscriber_trend AS
SELECT
    month,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data
GROUP BY month
ORDER BY month;

SELECT *
FROM vw_monthly_subscriber_trend
LIMIT 10;

/*View 2*/
CREATE OR REPLACE VIEW vw_state_analysis AS
SELECT
    state,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day,
    SUM(wireless_subscribers)
        / NULLIF(SUM(wireline_subscribers), 0)
        AS wireless_to_wireline_ratio
FROM telecom_data
GROUP BY state;

SELECT *
FROM vw_state_analysis
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/*View 3*/
CREATE OR REPLACE VIEW vw_provider_analysis AS
SELECT
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data
GROUP BY service_provider;

SELECT *
FROM vw_provider_analysis
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/* View 4*/
CREATE OR REPLACE VIEW vw_circle_analysis AS
SELECT
    telecom_circle_name,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers,
    AVG(vlr_peak_day) AS avg_vlr_peak_day
FROM telecom_data
GROUP BY telecom_circle_name;

SELECT *
FROM vw_circle_analysis
ORDER BY total_wireless_subscribers DESC NULLS LAST;

/* View 5*/
CREATE OR REPLACE VIEW vw_provider_state_analysis AS
SELECT
    state,
    service_provider,
    SUM(wireless_subscribers) AS total_wireless_subscribers,
    SUM(wireline_subscribers) AS total_wireline_subscribers
FROM telecom_data
GROUP BY
    state,
    service_provider;

	SELECT *
FROM vw_provider_state_analysis
ORDER BY total_wireless_subscribers DESC NULLS LAST;

CREATE OR REPLACE VIEW vw_state_circle_analysis AS
SELECT
    state,
    telecom_circle_name,
    SUM(wireless_subscribers) AS total_wireless_subscribers
FROM telecom_data
GROUP BY
    state,
    telecom_circle_name;