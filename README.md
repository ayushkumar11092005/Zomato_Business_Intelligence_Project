Zomato Business Intelligence and Delivery Time Prediction Platform
An End-to-End Data Analytics and Machine Learning Capstone Project


🔗 Repository Link
GitHub Repository URL: https://github.com/ayushkumar11092005/Zomato_Business_Intelligence_Project


📌 Executive Summary
The Zomato Business Intelligence and Delivery Time Prediction Platform is a multi-tier enterprise data capstone project. By integrating 12 relational CSV datasets, this platform addresses critical operational challenges in online food delivery, including kitchen preparation bottlenecks, peak-hour delivery latencies, margin compression from un-targeted promotional discounts, and customer churn.

The project encompasses a complete end-to-end data pipeline: from raw data ingestion and ETL preprocessing to complex SQL schema design, exploratory data analysis (EDA), interactive 6-page Power BI dashboarding, and predictive Machine Learning deployment (Random Forest Regression & Classification).

📁 Repository Structure
Zomato_Business_Intelligence_Project/
│
├── data/
│   ├── raw/                        # 12 Raw CSV datasets
│   └── cleaned/                    # Processed & cleaned CSV files
│
├── sql/
│   ├── schema.sql                  # Relational DDL schema script with primary/foreign keys
│   └── business_queries.sql        # 20+ analytical SQL business queries
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb      # Missing value imputation & outlier handling
│   ├── 02_eda.ipynb                # Statistical univariate & bivariate analysis
│   ├── 03_feature_engineering.ipynb# Feature extraction & encoding logic
│   ├── 04_delivery_time_model.ipynb# Random Forest Regression for delivery latency
│   └── 05_churn_model.ipynb        # Random Forest Classification for churn prediction
│
├── src/
│   ├── ingest.py                   # Automated raw data ingestion module
│   ├── clean.py                    # ETL data cleaning & deduplication pipeline
│   ├── features.py                 # Feature engineering & transformation functions
│   ├── model_delivery.py           # Machine learning pipeline for delivery time
│   └── model_churn.py              # Machine learning pipeline for customer churn
│
├── models/
│   ├── delivery_time_best_model.pkl # Serialized Random Forest Regressor artifact
│   └── churn_best_model.pkl        # Serialized Random Forest Classifier artifact
│
├── reports/
│   ├── eda_report.pdf              # Comprehensive Exploratory Data Analysis Report
│   ├── business_insights_report.pdf# Executive Strategic Business Report
│   └── presentation_deck.pdf       # 15-Slide Master Project Presentation Deck
│
├── powerbi/
│   └── zomato_dashboard.pbix       # 6-Page interactive Power BI Report file
│
├── images/
│   └── (exported chart images for README/report visuals)
│
├── documentation/
│   └── prd.docx                    # Product Requirements Document
│
├── README.md                       # Master project documentation
└── requirements.txt                # Python environment dependencies


🛠️ Technology Stack & Environment
Programming Language: Python 3.10+
Data Preprocessing & Analysis: Pandas, NumPy
Machine Learning & Modeling: Scikit-Learn, Joblib
Exploratory Data Analysis: Matplotlib, Seaborn
Database & Querying: SQL (MySQL / PostgreSQL dialect compatible), SQLAlchemy
Business Intelligence: Power BI Desktop (.pbix)

🧹 Data Preprocessing & Cleaning Audit
Across the 12 relational datasets (Orders, Customers, Restaurants, Delivery Partners, Payments, Feedback, Menu Items, Promotions, Locations, etc.), the following preprocessing routines were implemented:

1    Missing Value Imputation:
Identified missing customer feedback ratings and imputed them using median grouping aggregated by cuisine type and location.
Dropped corrupt transaction logs lacking valid primary identifiers.

2    Deduplication:
Enforced strict primary key constraints (orderid, customer_id, restaurant_id) to remove duplicate transaction logs.

3   Outlier Detection & Filtering:
Applied Interquartile Range (IQR) filtering (\text{Q1} - 1.5 \times \text{IQR} to \text{Q3} + 1.5 \times \text{IQR}) on deliverytimeminutes and order values, successfully filtering out telemetry/GPS errors (>120\text{ mins}).

4  Feature Engineering:
Extracted temporal variables: order_hour, day_of_week, and is_peak_hour (7:00 PM – 10:00 PM shift flag).
Engineered operational features: prep_time (kitchen prep delay) and distance_km (haversine travel distance).


📊 Exploratory Data Analysis (EDA) Highlights
Delivery Latency Skewness: deliverytimeminutes exhibits a right-skewed log-normal distribution with a median of 34 minutes. Evening peak shifts shift the mean travel duration to 48 minutes (+14\text{ to }+16\text{ mins} inflation).

Prep Delay vs. Order Cancellation: Bivariate correlation analysis established a strong positive correlation (r = 0.68) between kitchen prep times exceeding 25 minutes and customer order cancellation rates.

Discount Margin Erosion: Bivariate scatter analysis revealed that coupon usage increases Average Order Value (AOV) by ~12%, but compresses net operating margins from 22% down to 8–10%.

🎛️ Power BI Dashboard Architecture (.pbix)
The interactive Power BI dashboard is structured across 6 dedicated report pages:
Page 1  Executive Overview  KPI Cards (Total Revenue, Orders, Avg Delivery Time) & Monthly Revenue Line Trends.

Page 2 Restaurant Performance  Clustered Bar Charts ranking top 20% revenue vendors & Kitchen Prep Delay Matrix.

Page 3  Customer Behavior  Customer Cohort Donut Chart (Active vs. Churn Risk) & Order Frequency Distribution.

Page 4  Delivery Logistics  Delivery Partner Efficiency Column Charts & Peak Hour Traffic Congestion Heatmaps.

Page 5  Financials & Discounts  Detailed Profit & Loss Data Matrix breaking down food cost, GST, coupons, and net margins.

Page 6 Predictive Insights  Integration cards showing dynamic ML delivery time estimates & Churn Risk alerts.

🛢️ SQL Engineering & Database Scripts

sql/schema.sql: Full DDL script establishing table structures, primary keys, and foreign key relations ensuring 3NF database normalization.

sql/business_queries.sql: Contains 20+ production SQL queries, utilizing Common Table Expressions (CTEs), Window Functions (SUM() OVER(), RANK()), and multi-table INNER JOINs to extract operational metrics.

🤖 Machine Learning Models

Model 1: Delivery Time Prediction (Regression)

Objective: Predict total order delivery latency in minutes.

Algorithm: Random Forest Regressor (model_delivery.py)

Top Features: prep_time, distance_km, order_hour, weather_condition, partner_rating.

Serialized File: models/delivery_time_best_model.pkl

Performance Comparison

Model Candidate                     MAE (Minutes)  RMSE (Minutes)    R² Score
Linear Regression                      5.4             7.2             0.68
Decision Tree Regressor               4.1             5.8              0.76
Random Forest Regressor               2.8             3.9              0.85

Model 2: Customer Churn Prediction (Classification)

Objective: Predict customer churn risk (inactive for 30+ days).
Algorithm: Random Forest Classifier (model_churn.py)
Top Features: Recency of last order, total order count, discount reliance ratio, avg feedback score.
Serialized File: models/churn_best_model.pkl

Model Performance Metrics

Overall Accuracy: 88.4%

Recall Score (Churn Class): 0.86 (Optimized to minimize false negatives for retention targeting)
ROC-AUC Score: 0.91

💡 Strategic Business Recommendations

Dynamic ETA Integration: Embed the Random Forest delivery regression model into customer-facing checkout screens to reduce ETA inquiry support tickets by an estimated 25%.

Surge Zone Fleet Pre-allocation: Re-allocate delivery partners to high-density demand zones 30 minutes prior to evening peak hours (6:30 PM), cutting peak travel delays by ~14%.

Smart Discount Re-alignment: Restrict high-value coupon codes to customers identified as high churn risk by Model 2, protecting the standard 22% net profit margin on loyal customer orders.

✅ Final Deliverables Checklist Compliance

[x] Cleaned datasets across all 12 tables (data/cleaned/)
[x] SQL scripts (schema.sql + 20+ analytical business queries)
[x] Modular Python scripts (src/ingest.py, clean.py, features.py, modeling scripts)
[x] Jupyter notebooks covering cleaning, EDA, feature engineering, and both ML models
[x] Comprehensive EDA Report PDF (reports/eda_report.pdf)
[x] Business Insights Report PDF (reports/business_insights_report.pdf)
[x] Delivery time regression model + comparison table (.pkl exported)
[x] Customer churn classification model + comparison table (.pkl exported)
[x] Power BI dashboard (.pbix with 6 interactive pages)
[x] Final presentation deck (15 slides PDF format)
[x] GitHub repository with standardized directory layout
[x] Complete, professional README.md documentation
[x] Environment requirements file (requirements.txt)
[x] Product Requirements Document (documentation/prd.docx)

💻 How to Setup and Run:- 
1   Clone the Repository:
             git clone https://github.com/ayushkumar11092005/Zomato_Business_Intelligence_Project
             cd Zomato_Business_Intelligence_Project

2   Set Up Python Environment & Install Dependencies:
             python -m venv venv
            source venv/bin/activate  # On Windows: venv\Scripts\activate                pip install -r requirements.txt

 3   Execute ETL & Modeling Pipeline:
               python src/clean.py
               python src/features.py
               python src/model_delivery.py
               python src/model_churn.py

Open Power BI Dashboard:

Open powerbi/zomato_dashboard.pbix using Power BI Desktop to explore the 6 report pages.               
