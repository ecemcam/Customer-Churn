--Data Cleaning and EDA of the customer churn dataset.


--Data Cleaning:

select * from customer_churn;
 
--There are some missing values which the corresponding values in tenure are zero so i won't need them in my analysis i will delete those rows 
select *from customer_churn 
where totalcharges = ' ';

delete from customer_churn 
where totalcharges = ' ';

--Changing the data type of monthlycharges and totalcharges to decimal
alter table customer_churn
alter column totalcharges 
set data type decimal 
using totalcharges::decimal;

alter table customer_churn
alter column monthlycharges 
set data type decimal 
using monthlycharges::decimal;


--Mailed check requires sending papers so in paperless column needs to be corrected to No.
select *from customer_churn 
where paymentmethod ilike 'mailed check';

update customer_churn 
set paperlessbilling = 'No'
where paymentmethod ilike 'Mailed Check';

--The same issue happens here electronic check is paperless 
select *from customer_churn 
where paymentmethod ilike 'electronic check';

update customer_churn 
set paperlessbilling = 'Yes'
where paymentmethod ilike 'electronic check';

--The same steps applies to this value as well
select *from customer_churn 
where paymentmethod ilike 'credit card (automatic)';

update customer_churn 
set paperlessbilling = 'Yes'
where paymentmethod ilike 'credit card (automatic)';

--The same applies to this.
select *from customer_churn 
where paymentmethod ilike 'bank transfer (automatic)';

update customer_churn 
set paperlessbilling = 'Yes'
where paymentmethod ilike 'bank transfer (automatic)';

--Changing 1>> Yes, 0>>No in seniorcitizen column age>= 60 is Yes, below is No
update customer_churn 
set seniorcitizen = 'Yes'
where seniorcitizen = '1';

update customer_churn 
set seniorcitizen = 'No'
where seniorcitizen = '0';

select *from customer_churn;

----------------------------------------------------------------------------------------

--Checking for duplicates no duplicates.

with duplicate_cte as (
	select *, 
	row_number() over(partition by  customerid, gender, seniorcitizen, partner, dependents, tenure, phoneservice, multiplelines, internetservice,onlinesecurity, onlinebackup, deviceprotection, techsupport, streamingtv, streamingmovies, contract, paperlessbilling, paymentmethod, monthlycharges, totalcharges, churn) as row_num
	from customer_churn
)
select * from duplicate_cte
where row_num > 1;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--2.EDA:

--churn Customer Rate 
select
  count(*) filter (where churn = 'Yes') * 100.0 / count(*) as churn_percentage
from customer_churn;

--Subscribed Customers Rate 
select
  count(*) filter (where churn = 'No') * 100.0 / count(*) as churn_percentage
from customer_churn;

--Electronic Check Payment method has the highest churn count.
select count(*) as churn_count, paymentmethod, churn 
from customer_churn 
where churn ilike 'yes' 
group by paymentmethod, churn;


--Churn Rate for each contract type and tenure 
--I see that contract type 'Month-to-Month' has the highest churn rate 

select
  tenure,contract,
  round(count(*) filter (WHERE churn = 'Yes') * 100.0 / count(*), 2 ) as churn_percentage
from customer_churn
group by tenure, contract
order by tenure asc;

--Churn Rate decreases when tenure is increasing.
select
  tenure,
  round(count(*) filter (WHERE churn = 'Yes') * 100.0 / count(*), 2 ) as churn_percentage
from customer_churn
group by tenure
order by churn_percentage;

--I noticed that churn rate for the 1 month tenure is the highest 60% in Month-to-Month Payment Method in order order to know the reason I need to know which services they signed up for:
select
  tenure,contract,
  round(count(*) filter (WHERE churn = 'Yes') * 100.0 / count(*), 2 ) as churn_percentage
from customer_churn
where contract ilike 'month-to-month'
group by tenure, contract
order by tenure asc;

--I saw that 341 churned customer was using PhoneServices 
select
  tenure,contract, phoneservice, count(*) as users
from customer_churn
where contract ilike 'month-to-month' and tenure = 1 and churn ilike 'yes'
group by tenure, contract, phoneservice 
order by tenure asc;

--64 Churned Customer was using multiplelines service
select
  tenure,contract, phoneservice,multiplelines, count(*) as users
from customer_churn
where contract ilike 'month-to-month' and tenure = 1 and churn ilike 'yes'
group by tenure, contract, phoneservice, multiplelines
order by tenure asc;

--The Phone Service could be looked at for any dissatisfactions could be the reason for customers who are leaving after 1 month of being subscripted.



--Churned customer who had one year contract who were using phoneservices 
--152 customers were using.
select
  contract, phoneservice, count(*) as users
from customer_churn
where contract ilike 'one year' and churn ilike 'yes'
group by contract, phoneservice;

--93 Churned Customer was using Multiplelines 
select
  contract, phoneservice,multiplelines, count(*) as users
from customer_churn
where contract ilike 'one year' and churn ilike 'yes'
group by contract, phoneservice, multiplelines;


--1297 Churned Customers were using the internet service Fiber optic, 459 using DSL therre is definetely some dissatisfaction about Fiber Optic Internet
select
  internetservice,churn, count(*) as users
from customer_churn
where churn ilike 'yes'
group by internetservice, churn;

--183 Churned Customer was using FiberOptic Online Security the number is higher than the DSL should be looked at.
select
  internetservice,onlinesecurity, count(*) as users
from customer_churn
where churn ilike 'yes' and onlinesecurity ilike 'yes'
group by internetservice,churn, onlinesecurity;

--This also shows that Fiber Optic onlinebackup service higher rate of Churn than DSL.
select
  internetservice,onlinebackup, count(*) as users
from customer_churn
where churn ilike 'yes' and onlinebackup ilike 'yes'
group by internetservice,churn, onlinebackup;


--This also shows that Fiber Optic deviceprotection service higher rate of Churn than DSL.
select
  internetservice,deviceprotection, count(*) as users
from customer_churn
where churn ilike 'yes' and deviceprotection ilike 'yes'
group by internetservice,churn,deviceprotection;


--This also shows that Fiber Optic techsupport service higher rate of Churn than DSL.
select
  internetservice,techsupport, count(*) as users
from customer_churn
where churn ilike 'yes' and techsupport ilike 'yes'
group by internetservice,churn,techsupport;


--This also shows that Fiber Optic streamingtv service higher rate of Churn than DSL.
select
  internetservice,streamingtv, count(*) as users
from customer_churn
where churn ilike 'yes' and streamingtv ilike 'yes'
group by internetservice,churn,streamingtv;


--This also shows that Fiber Optic streamingmovies service higher rate of Churn than DSL.
select
  internetservice,streamingmovies ,count(*) as users
from customer_churn
where churn ilike 'yes' and streamingmovies  ilike 'yes'
group by internetservice,churn,streamingmovies;

--Those who quitted the service mostly were using FiberOptic Services.



----------------------------------------------------------------

--Internet service alone without using the Phone Service is more profitable.
select phoneservice, internetservice, sum(totalcharges) 
from customer_churn 
where internetservice ilike 'no' and phoneservice ilike 'yes'
group by phoneservice, internetservice
union 
select phoneservice, internetservice, sum(totalcharges) 
from customer_churn 
where not internetservice ilike 'no' and phoneservice ilike 'no'
group by phoneservice, internetservice;

--Using Phone Service along with the Fiber Internet service is more profitable than the Phone with DSL.
select phoneservice, internetservice, sum(totalcharges) 
from customer_churn 
where not internetservice ilike 'no' and phoneservice ilike 'yes'
group by phoneservice, internetservice;

--To know which internet services are most profitable:

--FiberOptic OnlineSecurity Service is more profitable than DSL.
select
  internetservice,onlinesecurity, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'yes' and onlinebackup ilike 'no' and deviceprotection ilike 'no' and techsupport ilike 'no'and streamingtv ilike 'no'and streamingmovies ilike 'no'
group by internetservice,onlinesecurity;


--FiberOptic onlinebackup Service is more profitable than DSL.
select
  internetservice,onlinebackup, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'no' and onlinebackup ilike 'yes' and deviceprotection ilike 'no' and techsupport ilike 'no'and streamingtv ilike 'no'and streamingmovies ilike 'no'
group by internetservice,onlinebackup;


--FiberOptic deviceprotection Service is more profitable than DSL.
select
  internetservice,deviceprotection, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'no' and onlinebackup ilike 'no' and deviceprotection ilike 'yes' and techsupport ilike 'no'and streamingtv ilike 'no'and streamingmovies ilike 'no'
group by internetservice,deviceprotection;


--DSL techsupport Service is more profitable than FiberOptic.
select
  internetservice,techsupport, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'no' and onlinebackup ilike 'no' and deviceprotection ilike 'no' and techsupport ilike 'yes' and streamingtv ilike 'no'and streamingmovies ilike 'no'
group by internetservice,techsupport;

--FiberOptic streamingtv Service is more profitable than DSL.
select
  internetservice,streamingtv, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'no' and onlinebackup ilike 'no' and deviceprotection ilike 'no' and techsupport ilike 'no' and streamingtv ilike 'yes'and streamingmovies ilike 'no'
group by internetservice,streamingtv;


--FiberOptic streamingtv Service is more profitable than DSL.
select
  internetservice,streamingmovies, sum(totalcharges)
from customer_churn
where onlinesecurity ilike 'no' and onlinebackup ilike 'no' and deviceprotection ilike 'no' and techsupport ilike 'no' and streamingtv ilike 'no'and streamingmovies ilike 'yes'
group by internetservice,streamingmovies;


--This shows that FiberOptic Services are more Profitable than DSL.


