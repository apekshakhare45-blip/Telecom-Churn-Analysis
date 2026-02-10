# Telecom-Churn-Analysis
This project analyzes customer churn behavior in a telecom company to identify high-risk customers, quantify revenue loss, and recommend data-driven retention strategies. Using SQL, Python, and Power BI, the analysis uncovers key churn drivers such as contract type, tenure, pricing, and service usage, and translates insights into actionable business recommendations.

# BUSINESS PROBLEM
Telecom companies face significant revenue loss due to customer churn.
The objective of this project is to:
- Identify which customers are most likely to churn
- Understand the key drivers behind churn
- Measure the revenue impact of churn
- Suggest actionable retention strategies

# DATASET INFORMATION
- Source: IBM Telco Customer Churn Dataset
- Records: 7,000+ customers
- Key Features:
  - Customer demographics (SeniorCitizen, Dependents)
  - Account information (Tenure, Contract, PaymentMethod)
  - Services subscribed (InternetService, Streaming, Security)
  - Financial metrics (MonthlyCharges, TotalCharges)
  - Target variable: Churn (Yes / No)

# KEY ANALYSIS PERFORMED
1. Data cleaning and preprocessing using Python (handled missing values, data types)
2. Exploratory data analysis to understand churn patterns
3. SQL-based analysis to answer business-driven questions
4. Customer segmentation based on tenure, contract, and pricing
5. Revenue impact and churn risk analysis
6. Dashboard creation for business storytelling

# KEY BUSSNESS INSIGHTS 
- New customers churn significantly more than long-term customers, indicating onboarding gaps
- Month-to-month contracts have the highest churn rate
- Customers with higher monthly charges show greater price sensitivity
- Fiber optic users contribute the highest revenue loss despite lower customer volume
- A large percentage of churn occurs within the first 6 months

# REVENUE IMPACT ANALYSIS
- Total revenue lost due to churn was quantified using TotalCharges
- High-value churned customers were identified based on tenure and pricing
- Estimated revenue saved if churn is reduced by 1%

# BUSSINESS RECOMMENDATIONS AND RETENTION STRATEGIES
- Improve onboarding experience for new customers
- Offer loyalty credits instead of permanent discounts
- Target high-risk, high-revenue customers with proactive outreach
- Encourage long-term contracts through bundled incentives
- Reduce payment friction by promoting auto-pay methods

# POWER BI DASHBOARD
The dashboard is divided into three sections:
1. Who is churning? – Customer segments and churn rates
2. Why are they churning? – Pricing, tenure, and service insights
3. What should we do? – Revenue impact and action-focused views

# TOOLS & TECHNOLOGIES USED
- SQL (MySQL) – Data analysis & business queries
- Python (Pandas, NumPy, Matplotlib) – Data cleaning & EDA
- Power BI – Interactive dashboard & storytelling
- GitHub – Version control & project documentation

# KEY LEARNINGS
- Translating data insights into business actions
- Designing dashboards with executive storytelling
- Understanding trade-offs between revenue and retention.

# FUTURE ENHANCEMENTS
- Predictive churn modeling using ML
- Customer lifetime value (CLV) analysis
- A/B testing of retention offers
 
