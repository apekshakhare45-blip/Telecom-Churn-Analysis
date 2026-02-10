CREATE DATABASE tele_customer_churn;
USE tele_customer_churn;
SELECT * FROM telechurn_cleaned_dset;

SELECT COUNT(DISTINCT customerID) FROM telechurn_cleaned_dset;

# 1.What is the overall churn rate?
SELECT SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*) as churn_rate
FROM telechurn_cleaned_dset;

# 2.How many customers have churned vs retained?
SELECT Churn , COUNT(*) as Customer_count 
FROM telechurn_cleaned_dset
GROUP BY Churn;

# 3.What is the average tenure of churned customers?
SELECT AVG(tenure) as avg_tenure, Churn
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes';

# 4.What percentage of total revenue comes from churned customers?
SELECT ROUND((SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END) * 100.0) 
/ SUM(TotalCharges),2) AS churned_revenue_percentage
FROM telechurn_cleaned_dset;

# 5.What is the average monthly charge for churned vs retained customers?
SELECT Churn, ROUND(AVG(MonthlyCharges),2) as avg_monthly_charges 
FROM telechurn_cleaned_dset
Group by Churn;

# 6.Does gender have any significant impact on churn?
SELECT gender, ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY Gender;
# Gender do not have any significant impact on churn.

# 7.Compare churn rates between senior citizens and non-senior citizens.
SELECT SeniorCitizen , ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY SeniorCitizen;

# revenue lost
SELECT SeniorCitizen , 
	   Contract,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
       round(sum(TotalCharges),2) revenue_lost,
       avg(tenure) as avg_tenure
FROM telechurn_cleaned_dset
GROUP BY SeniorCitizen,Contract;

# 8.How does having a partner affect churn?
SELECT Partner , 
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
       sum(TotalCharges) as revenue
FROM telechurn_cleaned_dset
GROUP BY Partner;
 # The churn rate of the people having partner is less as compared to the people without partner.
 
# 9.How does having dependents influence churn?
SELECT Dependents , 
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
       Sum(TotalCharges) as revenue
FROM telechurn_cleaned_dset
GROUP BY Dependents;
# The churn rate of the people having no dependents is more as compared to the people having dependents. 

# 10.Identify the demographic segment with the highest churn rate.
SELECT Partner , ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY Partner;

SELECT gender, ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY gender;

SELECT SeniorCitizen, ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY SeniorCitizen;

SELECT Dependents, ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY Dependents;
# Senior Citizens are churning at most

# 11.What is the churn rate by contract type?
SELECT Contract ,ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY Contract;
# Month-to-Month Contract Type contribute mostly to churn rate.
  
# 12.Compare churn rates across internet service types.  
SELECT InternetService ,
       Contract,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
       round(sum(TotalCharges),2) as revenue
FROM telechurn_cleaned_dset
GROUP BY InternetService, Contract
ORDER BY churn_rate desc, revenue DESC;

# 13.Does having tech support reduce churn significantly?
SELECT TechSupport , ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY TechSupport; 
# Yes, having tech support reduce churn significantly.

# 14.How does multiple line usage affect churn?
SELECT MultipleLines , ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY MultipleLines; 

# 15.Which payment method has the highest churn rate?
SELECT PaymentMethod,
       SeniorCitizen ,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY PaymentMethod,SeniorCitizen;
# Its Electronic check which has highest churn rate.

# 16.Is paperless billing associated with higher churn?
SELECT PaperlessBilling , ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY PaperlessBilling;

# 17.Compare average monthly charges across payment methods.
SELECT PaymentMethod ,
	   ROUND(AVG(MonthlyCharges),2) as avg_monthly_charges,
       Contract
FROM telechurn_cleaned_dset
GROUP BY PaymentMethod,Contract
ORDER BY PaymentMethod,ROUND(AVG(MonthlyCharges),2) desc;

# 18.Do customers with higher monthly charges churn more?
SELECT COUNT(*) AS total_customers, CASE 
      WHEN MonthlyCharges < 30 THEN 'LOW CHARGES'
      WHEN MonthlyCharges < 70 THEN 'MEDIUM CHARGES'
      ELSE 'HIGH'
      END AS charge_segment, 
      ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset
GROUP BY charge_segment
ORDER BY churn_rate DESC; 

# 19.What is the churn rate among customers paying above the dataset average?
SELECT ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS churn_rate_above_avg,
       COUNT(*) AS total_customers_above_avg
FROM telechurn_cleaned_dset
WHERE MonthlyCharges > (SELECT AVG(MonthlyCharges)
FROM telechurn_cleaned_dset);

# 20.Create tenure buckets and calculate churn rate for each bucket.
SELECT CASE WHEN tenure < 30 THEN 'LOW_TENURE'
            WHEN tenure BETWEEN 30 AND 60 THEN 'MEDUIM_TENURE'
            ELSE 'HIGH' 
		END AS tenure_bucket,
        Contract,
        ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
		COUNT(*) AS total_customers
FROM telechurn_cleaned_dset
GROUP BY tenure_bucket ,Contract
ORDER BY churn_rate DESC;

# tenure association with Payment Method
SELECT CASE WHEN tenure < 30 THEN 'LOW_TENURE'
            WHEN tenure BETWEEN 30 AND 60 THEN 'MEDUIM_TENURE'
            ELSE 'HIGH' 
		END AS tenure_bucket,
        PaymentMethod,
        ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
		COUNT(*) AS total_customers
FROM telechurn_cleaned_dset
GROUP BY tenure_bucket ,PaymentMethod
ORDER BY churn_rate DESC;

# 21.What percentage of churn happens within the first 6 months?
SELECT 
    ROUND(
        SUM(CASE WHEN tenure <= 6 AND Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END),
        2
    ) AS churn_percentage_first_6_months
FROM telechurn_cleaned_dset;
 
# on the basis of Internet Services
SELECT InternetService,
       ROUND(
           SUM(CASE WHEN Churn = 'Yes' AND tenure <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
           2
       ) AS early_churn_rate
FROM telechurn_cleaned_dset
GROUP BY InternetService
ORDER BY early_churn_rate DESC;

# on the bais of paymentmethod
SELECT PaymentMethod,
       ROUND(
           SUM(CASE WHEN Churn = 'Yes' AND tenure <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
           2
       ) AS early_churn_rate
FROM telechurn_cleaned_dset
GROUP BY PaymentMethod
ORDER BY early_churn_rate DESC;

# 22.At what tenure does churn significantly decrease?
SELECT CASE WHEN tenure < 20 THEN 'Low_tenure'
            WHEN tenure BETWEEN 20 AND 40 THEN 'Medium_tenure'
            ELSE 'High' END AS tenure_group,  
            SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)  as churned_customers,
COUNT(*) AS total_customers
FROM telechurn_cleaned_dset
GROUP BY tenure_group
ORDER BY churned_customers DESC;

# 23.Compare churn rates for new vs long-term customers.
SELECT CASE WHEN tenure < 8 THEN 'New_Customers'
	        ELSE 'Long_term_customers'END AS Type_of_customers,
            ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate
FROM telechurn_cleaned_dset 
GROUP BY Type_of_customers 
ORDER BY churn_rate;      
	
# 24.Which tenure group contributes most to revenue loss?
SELECT CASE WHEN tenure < 20 THEN 'Low_tenure'
            WHEN tenure BETWEEN 20 AND 40 THEN 'Medium_tenure'
            ELSE 'High' END AS tenure_group,
    ROUND(SUM(TotalCharges), 2) AS revenue_lost,
    COUNT(*) AS churned_customers
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes'
GROUP BY tenure_group
ORDER BY revenue_lost DESC;

# 25.Rank contract types by churn rate.
with churn_rank as (
SELECT Contract ,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) as churn_rate,
       COUNT(*) AS Total_customers
FROM telechurn_cleaned_dset
GROUP BY Contract) select *,
                         rank() over (order by churn_rate) as churn_rankings
from churn_rank;

# 26.Rank internet service types by revenue lost due to churn.
with rankings as (SELECT InternetService,
	   ROUND(SUM(TotalCharges), 2) AS revenue_lost,
       COUNT(*) AS churned_customers
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes'
GROUP BY InternetService
ORDER BY revenue_lost DESC) 
Select *,
       rank() over (order by revenue_lost desc) as ranks
from rankings;

# 27.For each contract type, calculate average monthly charges.
SELECT Contract , ROUND(AVG(MonthlyCharges),2) as Avg_monthly_charges
FROM telechurn_cleaned_dset
GROUP BY Contract;

# 28.Identify customers whose monthly charges are above their contract average.
SELECT t.customerID,t.Contract, t.MonthlyCharges
FROM telechurn_cleaned_dset t
WHERE t.MonthlyCharges > (SELECT(AVG(MonthlyCharges))
FROM telechurn_cleaned_dset
WHERE Contract = t.Contract);

# 29.Find customers who churned despite having below-average charges.
SELECT customerID,Contract,MonthlyCharges,TotalCharges
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes'
AND MonthlyCharges < (
        SELECT AVG(MonthlyCharges)
        FROM telechurn_cleaned_dset);

# 30.Calculate cumulative churn count ordered by tenure.
SELECT tenure,
       churn_count,
       SUM(churn_count) OVER (ORDER BY tenure) AS cumulative_churn_count
FROM (SELECT tenure,COUNT(*) AS churn_count
    FROM telechurn_cleaned_dset
    WHERE Churn = 'Yes'
    GROUP BY tenure
) t
ORDER BY tenure;
 
# 31.Compare individual customer tenure against segment averages.
SELECT customerID,Contract,tenure,
ROUND(AVG(tenure) OVER (PARTITION BY Contract), 2) AS avg_tenure_in_contract,
CASE 
	WHEN tenure > AVG(tenure) OVER (PARTITION BY Contract) THEN 'Above Segment Avg'
	WHEN tenure < AVG(tenure) OVER (PARTITION BY Contract) THEN 'Below Segment Avg'
	ELSE 'At Segment Avg'
    END AS tenure_comparison
FROM telechurn_cleaned_dset;

# 32.Identify high-risk customers based on:Month-to-month contract, Tenure < 12 months, High monthly charges
SELECT customerID, tenure, Contract, MonthlyCharges
FROM telechurn_cleaned_dset
WHERE Contract = 'Month-to-month' AND 
      Tenure < 12 AND
      MonthlyCharges > (SELECT AVG(MonthlyCharges)
      FROM telechurn_cleaned_dset);

# 33.Which retained customers are most likely to churn next?
SELECT customerID,Contract,tenure,MonthlyCharges
FROM telechurn_cleaned_dset
WHERE Churn = 'No'   -- currently retained
  AND Contract = 'Month-to-month'
  AND tenure < 12
  AND MonthlyCharges > (
        SELECT AVG(MonthlyCharges)
        FROM telechurn_cleaned_dset)
ORDER BY MonthlyCharges DESC;
SELECT Contract
FROM telechurn_cleaned_dset
GROUP BY Contract;

# 34.How many high-value customers have churned?
SELECT customerID, Contract, Churn, tenure, MonthlyCharges
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes'
  AND Contract IN ('One year', 'Two year')   
  AND tenure > 12
  AND MonthlyCharges > (
        SELECT AVG(MonthlyCharges)
        FROM telechurn_cleaned_dset);

# 35.How much total revenue has been lost due to churn?
SELECT Churn, ROUND(SUM(TotalCharges),2) AS total_revenue
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes'
GROUP BY Churn;

# 36.Estimate revenue saved if churn reduces by 1%.
SELECT ROUND(SUM(TotalCharges), 2) AS total_revenue_lost,
ROUND(SUM(TotalCharges) * 0.01, 2) AS revenue_saved_if_1pct_churn_reduced
FROM telechurn_cleaned_dset
WHERE Churn = 'Yes';





