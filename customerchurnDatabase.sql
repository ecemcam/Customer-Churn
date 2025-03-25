create database customer_churn;

create table customer_churn(
	CustomerID varchar(255) primary key, 
	Gender varchar(255), 
	SeniorCitizen text, 
	Partner varchar(255), 
	Dependents varchar(255), 
	Tenure int, 
	PhoneService varchar(255), 
	MultipleLines varchar(255),
	InternetService varchar(255),
	OnlineSecurity	varchar(255),
	OnlineBackup	varchar(255),
	DeviceProtection varchar(255),
	TechSupport varchar(255),
	StreamingTV varchar(255),
	StreamingMovies	varchar(255),
	Contract	varchar(255),
	PaperlessBilling varchar(255),
	PaymentMethod	varchar(255),
	MonthlyCharges	text null,
	TotalCharges    text null,
	Churn		varchar(255)
);

select *from customer_churn;
