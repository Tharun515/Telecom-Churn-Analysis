# 📊 Telecom Subscriber & Market Analysis

### End-to-End Data Analytics Project | Excel | Power Query | PostgreSQL | SQL | Power BI

![Project](https://img.shields.io/badge/Project-Telecom%20Analytics-blue)
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791)
![Power BI](https://img.shields.io/badge/Visualization-Power%20BI-F2C811)
![Excel](https://img.shields.io/badge/Data%20Preparation-Excel-217346)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

## 📌 1. Project Overview

This project is an end-to-end data analytics solution focused on understanding subscriber trends and market performance in the Indian telecommunications industry.

The analysis uses 58,533 records sourced from the Ministry of Communications, Government of India.

The project follows a structured analytics workflow, starting with raw dataset inspection and data preparation in Excel and Power Query, followed by SQL-based analysis using PostgreSQL and finally the development of interactive Power BI dashboards.

The primary objective is to transform raw telecom statistics into meaningful business insights by examining wireless and wireline subscriber trends, service provider performance, state-wise distribution, and Visitor Location Register (VLR) metrics.

Rather than focusing only on visualizations, this project demonstrates the complete process of preparing, querying, analyzing and presenting structured data.

## 🎯 2. Business Objectives

- Analyze the growth and distribution of wireless and wireline subscribers.
- Understand monthly subscriber trends across reporting periods.
- Compare telecom service providers based on subscriber performance.
- Identify leading service providers using ranking analysis.
- Examine subscriber distribution across Indian states and telecom circles.
- Analyze the relationship between VLR and wireless subscribers.
- Develop interactive dashboards to support data-driven decision-making.

## 📂 3. Dataset Description

| Attribute | Details |
|---|---|
| Dataset Source | Ministry of Communications, Government of India |
| Total Records | 58,533 |
| Geographic Coverage | 35 States/Regions |
| Industry | Indian Telecommunications |
| Data Type | Subscriber and telecom market statistics |

### Key Dataset Dimensions

- Reporting period and monthly information
- State and telecom circle
- Service provider
- Wireless subscribers
- Wireline subscribers
- VLR-related metrics

The dataset provides a historical view of the telecom market and enables comparisons across reporting periods, geographical regions and service providers.

## 🔄 4. End-to-End Data Pipeline

The project follows a structured data analytics pipeline.

**Raw Dataset → Data Cleaning → PostgreSQL → SQL Analysis → Power BI Data Model → DAX Measures → Interactive Dashboards**

### Stage 1: Data Collection and Inspection

- Collected the telecom dataset from the government data source.
- Examined the dataset structure, columns and data types.
- Identified missing values, inconsistencies and formatting issues.
- Reviewed subscriber metrics and reporting dimensions.

### Stage 2: Data Cleaning and Transformation

**Tools: Microsoft Excel and Power Query**

Performed data preparation activities such as:

- Handling missing and inconsistent values.
- Standardizing column names and formats.
- Checking data types and formatting.
- Preparing reporting-period and categorical fields.
- Reviewing duplicate records and data consistency.
- Structuring the dataset for database loading and analysis.

### Stage 3: Database Management

**Tool: PostgreSQL**

Loaded the prepared telecom dataset into PostgreSQL for structured querying and analytical processing.

PostgreSQL was used to organize the data, perform aggregations, compare service providers, analyze subscriber trends and prepare analytical outputs.

### Stage 4: SQL Analysis

Performed SQL-based analysis using:

- SELECT and WHERE for data retrieval and filtering.
- GROUP BY for state-wise and provider-wise aggregations.
- ORDER BY for sorting and performance comparisons.
- Aggregate functions such as SUM, AVG, COUNT and MAX.
- CASE statements for conditional classification.
- JOIN operations for combining related datasets.
- Common Table Expressions (CTEs) for organizing complex queries.
- Subqueries for nested analytical calculations.
- Window functions for ranking and comparative analysis.

### Stage 5: Power BI Integration

Connected the prepared analytical data to Power BI and developed the reporting model.

Activities included:

- Importing and organizing analytical tables and views.
- Configuring data relationships where applicable.
- Creating DAX measures for KPI calculations.
- Building interactive slicers and visualizations.
- Designing a three-page dashboard for different analytical perspectives.

## 🐘 5. PostgreSQL – SQL Analysis

PostgreSQL played an important role in converting the prepared dataset into structured analytical outputs.

### SQL Techniques and Their Applications

| SQL Concept | Application |
|---|---|
| GROUP BY | State-wise and provider-wise analysis |
| SUM() | Subscriber aggregation |
| AVG() | Average VLR-related metrics |
| MAX() | Identifying maximum reported values |
| CASE WHEN | Conditional classification |
| JOIN | Combining related analytical datasets |
| CTE | Structuring multi-step queries |
| Subqueries | Nested calculations |
| Window Functions | Ranking service providers and comparisons |

### Examples of Analytical Queries

**1. Service Provider Performance**

Aggregating wireless subscribers by service provider.

```sql
SELECT
    "Service Provider",
    SUM("Wireless Subscribers") AS total_subscribers
FROM telecom_data
GROUP BY "Service Provider"
ORDER BY total_subscribers DESC;
```

**2. State-wise Subscriber Analysis**

```sql
SELECT
    "State",
    SUM("Wireless Subscribers") AS wireless_subscribers,
    SUM("Wireline Subscribers") AS wireline_subscribers
FROM telecom_data
GROUP BY "State"
ORDER BY wireless_subscribers DESC;
```

**3. Monthly Subscriber Analysis**

The monthly analysis examines subscriber changes across reporting periods and helps identify growth patterns and fluctuations.

**4. Service Provider Ranking**

Window functions such as RANK() and DENSE_RANK() can be used to compare providers based on subscriber performance.

**5. VLR Analysis**

Aggregations and comparative analysis were used to examine VLR-related metrics alongside wireless subscriber statistics.

*Note: The SQL snippets above illustrate the analytical approach. Column names and query versions should match the actual uploaded SQL scripts.*

### Analytical SQL Views

The project also uses analytical views to organize data for reporting.

Examples of project views include:

- `vw_monthly_subscriber_trend` – Monthly subscriber trend analysis.
- `vw_state_analysis` – State-level analytical output.

These views help separate analytical preparation from dashboard visualization.

## 📊 6. Power BI Dashboard Development

The Power BI solution consists of three interactive dashboard pages.

### Dashboard 1: Telecom Overview

**Purpose:** Provide a consolidated overview of the Indian telecom subscriber market.

Key analytical components:

- Wireless subscriber overview.
- Wireline subscriber overview.
- Subscriber KPI cards.
- Wireless and wireline comparison.
- Monthly subscriber trend analysis.
- Interactive reporting filters.

### Dashboard 2: State-wise Analysis

**Purpose:** Understand geographical differences in subscriber distribution.

Key analytical components:

- State-wise subscriber comparison.
- Wireless subscriber distribution.
- Wireline subscriber distribution.
- Regional performance comparison.
- State-based filtering and exploration.

### Dashboard 3: Service Provider Analysis

**Purpose:** Evaluate telecom service provider performance and subscriber distribution.

Key analytical components:

- Provider-wise subscriber comparison.
- Top 10 service provider analysis.
- Wireless and wireline performance.
- VLR-related analysis.
- Provider-level comparisons and trends.

## 📐 7. Power BI KPIs and DAX Measures

KPI cards and analytical measures were developed to convert subscriber statistics into meaningful performance indicators.

### Key Performance Indicators

| KPI | Business Purpose |
|---|---|
| Total Wireless Subscribers | Measures the wireless subscriber base |
| Total Wireline Subscribers | Measures the wireline subscriber base |
| Total Subscribers | Combines wireless and wireline subscriber metrics |
| Average VLR Metric | Examines average VLR-related performance |
| State Coverage | Indicates the geographical coverage of the analysis |
| Service Provider Count | Measures the number of providers represented |
| Monthly Subscriber Trend | Tracks subscriber movement over time |

### DAX Calculation Logic

The following examples demonstrate the types of DAX calculations relevant to the dashboard. They should be aligned with the actual column names and measures in the uploaded PBIX file.

**Total Wireless Subscribers**

```dax
Total Wireless Subscribers =
SUM(telecom_data[Wireless Subscribers])
```

**Total Wireline Subscribers**

```dax
Total Wireline Subscribers =
SUM(telecom_data[Wireline Subscribers])
```

**Total Subscribers**

```dax
Total Subscribers =
[Total Wireless Subscribers] +
[Total Wireline Subscribers]
```

**Number of Service Providers**

```dax
Service Provider Count =
DISTINCTCOUNT(telecom_data[Service Provider])
```

**Number of States**

```dax
State Count =
DISTINCTCOUNT(telecom_data[State])
```

### KPI Design Approach

- Used aggregation measures to summarize subscriber statistics.
- Applied filter context to enable interactive analysis.
- Designed KPI cards for quick performance interpretation.
- Used time-based analysis to understand monthly movements.
- Compared wireless and wireline subscriber metrics.
- Used provider and geographical dimensions for comparative analysis.

## 🎛️ 8. Dashboard Interactivity

The dashboards include interactive filtering capabilities to make the analysis more flexible.

Available analytical filters include:

- Year
- State
- Service Provider

These filters allow users to explore subscriber performance across different time periods, geographical regions and telecom operators.

## 📈 9. Key Analytical Findings

The project explores several important aspects of the Indian telecommunications market:

1. Wireless and wireline subscribers have different market distributions.
2. Subscriber trends provide insights into changes across reporting periods.
3. Service provider comparisons highlight differences in market presence.
4. State-wise analysis reveals geographical variations in subscriber distribution.
5. VLR metrics provide an additional perspective on wireless subscriber activity.

The analysis is intended to support historical telecom market understanding rather than individual customer churn prediction.

## 🧰 10. Technology Stack

| Technology | Role in Project |
|---|---|
| Microsoft Excel | Initial data inspection |
| Power Query | Data cleaning and transformation |
| PostgreSQL | Database management and SQL analysis |
| SQL | Data aggregation and analytical queries |
| Power BI | Dashboard development |
| DAX | KPI calculations and analytical measures |

## 📁 11. Repository Structure

```text
Telecom-Churn-Analysis/
│
├── 01_Raw_Data/
│   └── Original_Dataset.csv
│
├── 02_Cleaned_Data/
│   └── Cleaned_Dataset.csv
│
├── 03_SQL/
│   └── SQL_Analysis.sql
│
├── 04_PowerBI/
│   └── Telecom_Dashboard.pbix
│
├── 05_Dashboard_Screenshots/
│   ├── Telecom_Overview.png
│   ├── State_Analysis.png
│   └── Service_Provider_Analysis.png
│
├── 06_Documentation/
│   └── Project_Report.pdf
│
└── README.md
```

*Repository folder names and filenames should reflect the actual uploaded files.*

## 🚀 12. Skills Demonstrated

- Data Cleaning and Preprocessing
- Exploratory Data Analysis
- PostgreSQL Database Management
- Advanced SQL Querying
- Data Aggregation and Transformation
- Analytical View Creation
- Power BI Dashboard Development
- DAX Measures and KPI Design
- Data Visualization
- Business and Market Analysis

## 👨‍💻 13. Author

**Tharun U**

B.Tech – Computer Science and Engineering

Aspiring Data Analyst | SQL | PostgreSQL | Power BI | Excel

---

⭐ If you find this project useful, feel free to explore the repository and share your feedback.

**Project Focus:** Transforming raw telecom data into meaningful analytical insights through SQL and Power BI.
