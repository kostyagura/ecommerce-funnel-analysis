# 📊 E-commerce Campaign & Funnel Analysis (SQL + BigQuery + GA4)

## 📝 Project Description
This project includes the full workflow of digital marketing data analysis and eCommerce user behavior analytics.  
The analysis is based on:
- Advertising campaign data from **Google Ads** and **Facebook Ads** (PostgreSQL)
- Exported **Google Analytics 4** events into **BigQuery**

The project includes:
1. **Marketing analysis**: spend, efficiency, and ROMI.
2. **Sales funnel construction**: from session start to purchase.
3. **Conversion calculations**: by traffic channels, dates, and landing pages.
4. **Correlation analysis** between user engagement and purchases.

---

## 🎯 Project Goals
- Obtain detailed performance metrics of advertising campaigns.
- Identify key user drop-off points in the funnel.
- Build SQL scripts ready for BI visualization.
- Practice advanced queries in PostgreSQL and BigQuery.

---

## 🛠 Tools & Technologies
- **SQL**: PostgreSQL (DBeaver), Google BigQuery
- **Data Sources**:
  - `ads_analysis_goit_course` (PostgreSQL)
  - Public GA4 eCommerce dataset (BigQuery)
- **Metrics**: ROMI, reach, conversions, engagement time
- **Methodology**: Funnel Analysis, Time-series Aggregation, Correlation Analysis

---

## 📂 Repository Structure
- `sql/` – всі SQL-запити
- `outputs/` – результати виконання запитів у CSV
- `README.md` 
### 📝 SQL Scripts

#### PostgreSQL Queries (Task 1)
- [PostgreSQL_daily_spend_stats.sql](sql/PostgreSQL_daily_spend_stats.sql) – Average, min, max daily spend by platform
- [PostgreSQL_top5_days_by_romi.sql](sql/PostgreSQL_top5_days_by_romi.sql) – Top 5 days with highest ROMI
- [PostgreSQL_highest_weekly_value_campaign.sql](sql/PostgreSQL_highest_weekly_value_campaign.sql) – Campaign with highest weekly value
- [PostgreSQL_monthly_reach_growth.sql](sql/PostgreSQL_monthly_reach_growth.sql) – Largest month-over-month reach increase

#### BigQuery Queries (Tasks 2–5)
- [BigQuery_ga4_events_extraction.sql](sql/BigQuery_ga4_events_extraction.sql) – Extract required GA4 events with selected dimensions
- [BigQuery_conversion_funnel.sql](sql/BigQuery_conversion_funnel.sql) – Build conversion funnel metrics by date, source, medium, campaign
- [BigQuery_landing_page_conversion.sql](sql/BigQuery_landing_page_conversion.sql) – Compare conversions by landing page
- [BigQuery_engagement_purchase_correlation.sql](sql/BigQuery_engagement_purchase_correlation.sql) – Check correlation between engagement and purchases



### 📊 Output CSVs

#### PostgreSQL Results
- [PostgreSQL_daily_spend_stats.csv](outputs/PostgreSQL_daily_spend_stats.csv) – Output of Task 1: Average, min, max daily spend by platform
- [PostgreSQL_top5_days_by_romi.csv](outputs/PostgreSQL_top5_days_by_romi.csv) – Output of Task 1: Top 5 days with highest ROMI
- [PostgreSQL_highest_weekly_value_campaign.csv](outputs/PostgreSQL_highest_weekly_value_campaign.csv) – Output of Task 1: Campaign with highest weekly value
- [PostgreSQL_monthly_reach_growth.csv](outputs/PostgreSQL_monthly_reach_growth.csv)– Output of Task 1: Largest month-over-month reach increase

#### BigQuery Results
- [BigQuery_ga4_events_extraction.csv](outputs/BigQuery_ga4_events_extraction.csv?raw=true) – Output of Task 2: Extract required GA4 events with selected dimensions
- [BigQuery_conversion_funnel.csv](outputs/BigQuery_conversion_funnel.csv) – Output of Task 3: Conversion funnel metrics by date, source, medium, campaign
- [BigQuery_landing_page_conversion.csv](outputs/BigQuery_landing_page_conversion.csv) – Output of Task 4: Compare conversions by landing page
- [BigQuery_engagement_purchase_correlation.csv](outputs/BigQuery_engagement_purchase_correlation.csv) – Output of Task 5: Correlation between engagement and purchases

---

## 📌 Task Descriptions

### **Task 1: Campaign Details Exploration**
- **Source:** PostgreSQL (`ads_analysis_goit_course`)
- **Objectives:**
  - Calculate average, minimum, and maximum daily spend for Google and Facebook Ads.
  - Identify the top-5 days by ROMI.
  - Determine the campaign with the highest weekly value.
  - Find the largest month-over-month reach increase.

---

### **Task 2: GA4 Data Preparation in BigQuery**
- **Source:** Public GA4 eCommerce dataset (2021)
- **Objectives:**
  - Extract events: `session_start`, `view_item`, `add_to_cart`, `begin_checkout`, `add_shipping_info`, `add_payment_info`, `purchase`.
  - Keep dimensions: timestamp, users, sessions, country, device, traffic source, campaign name.

---

### **Task 3: Conversion Calculations**
- **Goal:** Build a conversion funnel (from session start to purchase) by **date + source + medium + campaign**.
- **Metrics:** `visit_to_cart`, `visit_to_checkout`, `visit_to_purchase`.

---

### **Task 4: Landing Page Conversion Comparison**
- **Source:** GA4 dataset (2020)
- **Objectives:**
  - Identify the **page path** of the session start.
  - Calculate conversion from session start to purchase.

---

### **Task 5: Correlation Checks**
- **Goal:** Examine the relationship between user engagement and purchases.
- **Metrics:** `session_engaged`, `engagement_time_msec`, purchase event.

---

## 📈 Results
- SQL queries work in PostgreSQL and BigQuery without errors.
- Built analytical tables ready for BI integration.
- Identified top-performing campaigns and landing pages with the highest conversions.
- Calculated conversions and identified user drop-off points in the funnel.

---

## 👤 Author
**Kostya Gura** — Data Analyst  
📧 Email: gurakostya96@icloud.com  
🔗 LinkedIn: www.linkedin.com/in/kostya-gura
