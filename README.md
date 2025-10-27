# Game Analytics Dashboard: BigQuery + Looker Case Study

## Project Description

This project is a full-stack analytics pipeline for a large mobile game's user journey, built using SQL (BigQuery) for data modeling and Looker for dashboard visualization. The goal: provide actionable business insights on retention, monetization, user segmentation, and the impact of A/B testing for game growth strategy.

## Looker Dashboard - [CLICK HERE](https://lookerstudio.google.com/reporting/f43f9aee-e61c-417e-be3d-124cfac4d195)

---

## Dataset Overview

This project analyzes the [Gamelytics mobile analytics challenge dataset](https://www.kaggle.com/datasets/debs2x/gamelytics-mobile-analytics-challenge), simulating real-world user registration, login (activity), and A/B test monetization data for a large-scale free-to-play mobile game. 

Main files used:
- **reg_data.csv:** User registration timestamps and IDs (1,000,000 records)
- **auth_data.csv:** All user login/authentication events over time (9.6 million rows)
- **ab_test.csv:** Subset of users included in an A/B test, with revenue and group assignment (404,770 rows)

---

## Data Engineering: BigQuery Design

**Database Name:** `game_analytics`  
Tables: `reg_data`, `auth_data`, `ab_test`

### Data Loading & Partitioning

To handle large-scale event history (10M+ rows), all fact data is partitioned by timestamp and clustered by user ID for query speed and cost efficiency.

---
### Query & View Design

All analyses (EDA, LTV, DAU/MAU, retention, monetization, AB test) are created as **SQL views** for modular, scalable reporting.  

- See Here - [notebooks](https://github.com/Vaibhav-180500/Game_Analytics_using_SQL_and_Looker/tree/main/notebooks)

---

## Business Problem Statement

Despite a large and growing user base, overall game monetization and long-term engagement remain weak. Stakeholders want to identify which user segments to target for retention, which behavioral cohorts generate the most value, and whether recent product experiments (A/B tests) are improving either retention or revenue.

> **Key Objectives**  
> - Reduce churn  
> - Grow revenue from existing users  
> - Better segment player engagement and value

### Key Analysis Questions

- How do user retention and churn trends evolve across all cohorts?
- What is the magnitude and distribution of paying users—are “whale” players responsible for most revenue, or is revenue broadly distributed?
- How does LTV evolve over time for new registrants? Are newer cohorts monetizing more or less?
- Can we identify distinct engagement profiles (e.g., casual one-timers vs. power users vs. core “superfans”), and what percent of each drive game health?
- Did the A/B test variant improve monetization or retention relative to control, and is it significant?

---

## Dashboard Structure

The analysis uses a modular multi-tab dashboard. **Insert screenshots or images in the spaces indicated below.**

---

### 1. Overview

- **KPI Cards:** 
  - Total Users
  - Users since 2015
  - Users in A/B Test
  - Paying Users
  - ARPU, ARPPU
  - Avg Lifespan

<img width="966" height="751" alt="image" src="https://github.com/user-attachments/assets/a3b50279-f913-457a-ab6b-5e99990cb89f" />


---

### 2. Engagement & Retention

- **DAU/MAU Trends:** Line charts for daily/monthly active users  
- **Cohort Retention:** Multi-line chart for D1/D7/D30 rates by cohort  
- **User Types:** Bar chart (“one-timers,” “early retained,” etc.)  
- **Daily Churn:** Line chart for user churn

<img width="1232" height="692" alt="image" src="https://github.com/user-attachments/assets/edd625c6-9907-4fc5-9eef-b5d7b401b45c" />

<img width="1140" height="794" alt="image" src="https://github.com/user-attachments/assets/80b2170b-8bc2-4c0e-8812-021d677f8e30" />

---

### 3. Monetization

- **LTV Evolution Over Time:** Combo line/bar chart for LTV by cohort/month  
- **Revenue Segmentation:** Pie chart (non-paying, whales, etc.)  
- **Summary Table:** Revenue buckets and value distribution

<img width="1064" height="804" alt="image" src="https://github.com/user-attachments/assets/524add20-7a93-4231-a391-83886169b5e1" />



---

### 4. A/B Test Analysis

- **Bar Charts:** Total Users, Total Payers, Total Revenue by testgroup  
- **Summary Table:** Users, payers, total revenue, avg revenue per group

<img width="1073" height="706" alt="image" src="https://github.com/user-attachments/assets/bc7275a7-0b4d-47e6-ad59-0bca8de95165" />

---

## Interpretation & Insights

### Retention & Churn

- Retention rates (D1/D7/D30) are low and daily churn is trending upwards, indicating onboarding issues and a need to improve early game retention.

### Paying User Distribution

- Less than 0.5% of users pay at all. Most revenue comes from a tiny fraction (“whales”), making overall revenue vulnerable to churn in this segment. Broadening payer base is essential.

### LTV Evolution

- LTV is flat or declining for most recent cohorts. Registration growth is not translating into monetization growth.

### Engagement Segments

- 80%+ of users are “one-timers” or churn after minimal play. Very few become core/power users, but those who do are critical for monetization.

### Experiment Impact

- The A/B test did not result in a statistically significant revenue or retention difference. No justification to roll out variant features globally.

---

## Strategic Recommendations

- Invest in new user onboarding, first-session experience, and win-back automations.
- Develop monetization offers or features for both whales and small spenders.
- Double down on features shown to retain “superfans” while addressing early churners.
- Only scale A/B tested features if future tests show clear, significant improvements in primary KPIs.

---

## How to Use This Repo

- View `notebooks/` for full SQL queries and analysis steps.
- View `dashboard/` for Looker/Tableau screenshots and dashboard structure.

---

