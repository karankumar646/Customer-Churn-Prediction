DROP TABLE IF EXISTS public.stg_churn;

CREATE TABLE public.stg_churn (
    Customer_ID VARCHAR,
    Gender VARCHAR,
    Age INT,
    Married VARCHAR,
    State VARCHAR,
    Number_of_Referrals INT,
    Tenure_in_Months INT,
    Value_Deal VARCHAR,
    Phone_Service VARCHAR,
    Multiple_Lines VARCHAR,
    Internet_Service VARCHAR,
    Internet_Type VARCHAR,
    Online_Security VARCHAR,
    Online_Backup VARCHAR,
    Device_Protection_Plan VARCHAR,
    Premium_Support VARCHAR,
    Streaming_TV VARCHAR,
    Streaming_Movies VARCHAR,
    Streaming_Music VARCHAR,
    Unlimited_Data VARCHAR,
    Contract VARCHAR,
    Paperless_Billing VARCHAR,
    Payment_Method VARCHAR,
    Monthly_Charge NUMERIC,
    Total_Charges NUMERIC,
    Total_Refunds NUMERIC,
    Total_Extra_Data_Charges NUMERIC,
    Total_Long_Distance_Charges NUMERIC,
    Total_Revenue NUMERIC,
    Customer_Status VARCHAR,
    Churn_Category VARCHAR,
    Churn_Reason VARCHAR
);


SELECT * FROM public.stg_churn LIMIT 10;



SELECT Gender, Count(Gender) as TotalCount,
Count(Gender) * 1.0 / (Select Count(*) from stg_Churn) as Percentage
from stg_Churn
Group by Gender


SELECT Contract, Count(Contract) as TotalCount,
Count(Contract)* 1.0 /(Select Count(*)from stg_Churn) as Percentage
from stg_Churn
Group by Contract

SELECT Customer_Status, Count(Customer_Status) as TotalCount, Sum(Total_Revenue) as TotalRev,
Sum(Total_Revenue) / (Select sum(Total_Revenue)from stg_Churn) * 100  as RevPercentage
from stg_Churn
Group by Customer_Status



SELECT State, Count(State) as TotalCount,
Count(State) * 100.0 / (Select Count(*) from stg_Churn) as Percentage
from stg_Churn
Group by State
Order by Percentage desc


SELECT
SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM stg_Churn;





CREATE TABLE prod_churn AS
SELECT
    customer_id,
    gender,
    age,
    married,
    state,
    number_of_referrals,
    tenure_in_months,
    COALESCE(value_deal, 'None') AS value_deal,
    phone_service,
    COALESCE(multiple_lines, 'No') AS multiple_lines,
    internet_service,
    COALESCE(internet_type, 'None') AS internet_type,
    COALESCE(online_security, 'No') AS online_security,
    COALESCE(online_backup, 'No') AS online_backup,
    COALESCE(device_protection_plan, 'No') AS device_protection_plan,
    COALESCE(premium_support, 'No') AS premium_support,
    COALESCE(streaming_tv, 'No') AS streaming_tv,
    COALESCE(streaming_movies, 'No') AS streaming_movies,
    COALESCE(streaming_music, 'No') AS streaming_music,
    COALESCE(unlimited_data, 'No') AS unlimited_data,
    contract,
    paperless_billing,
    payment_method,
    monthly_charge,
    total_charges,
    total_refunds,
    total_extra_data_charges,
    total_long_distance_charges,
    total_revenue,
    customer_status,
    COALESCE(churn_category, 'Others') AS churn_category,
    COALESCE(churn_reason, 'Others') AS churn_reason
FROM stg_churn;

select * from prod_churn


create view vw_Churndata as
   select * from prod_churn where customer_status in ('Churned','Stayed')

create view vw_Joindata as
   SELECT * FROM prod_churn WHERE LOWER(TRIM(customer_status)) = 'joined';
   
select * from vw_joindata


