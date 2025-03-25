
# 📊 Customer Churn Analysis Dashboard

This Power BI dashboard visualizes churn behavior and key customer retention metrics to help business teams proactively manage churn risk, optimize marketing strategies, and improve customer satisfaction.

---

## Objective

The goal is to analyze churn patterns by customer behavior, demographics, and subscription features, identify at-risk segments, and surface actionable insights for improving retention and reducing revenue loss.

---

## Data Pipeline Overview

**Data Source**:  
- Relational database simulated via `customerchurnDatabase.sql`
- Cleaned and transformed using SQL logic in `Cleaning&EDA.sql`

**Data Includes**:
- Customer demographics (gender, seniority, partner/dependents)
- Account details (tenure, contract type, payment method)
- Service usage (internet service, tech support, streaming, etc.)
- Target variable: `Churn` (Yes/No)

---

##  Data Cleaning & Feature Engineering

Performed in `Cleaning&EDA.sql`:
- Handled missing values and formatted categorical fields
- Created binary flags for multiple services
- Encoded `Churn` for use in charts and ML pipelines
- Normalized numerical fields for churn pattern analysis

---

## Power BI Dashboard Features

###  Key Metrics:
- **Overall Churn Rate**
- **Monthly Active vs. Churned Customers**
- **Churn Rate by Contract Type, Tenure, and Payment Method**
- **Revenue at Risk** from churned customers

### Visuals Include:
- Line chart: Churn Rate over Tenure 
- Bar charts: Churn by Contract, Internet Service, Payment Method
- Stacked charts: Customer Distribution by Tenure Group & Churn
- Pie/Donut: Overall Churn % and Active % split
- Table: Customer-level churn and service usage breakdown

###  Slicers for:
- Gender

---

## Tech Stack

- **Power BI** for dashboard and DAX measures
- **SQL** (`Cleaning&EDA.sql`) for preprocessing and transformations

---

## 📁 Project Structure

```bash
📁 CustomerChurnProject/
│
├── CustomerChurn.pbix               # Power BI Dashboard
├── customerchurnDatabase.sql       # Raw schema and sample data
├── Cleaning&EDA.sql                # Data cleaning & transformations
├── WA_Fn-UseC_-Telco-Customer-Churn.csv     # Source Data CSV File
└── README.md                       # Project documentation (this file)
```
### Dashboard 

![Image](https://github.com/user-attachments/assets/af44d01c-fc54-4ac6-b824-041216f7da27)
