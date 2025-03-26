--Creating the table 
create table transactions (
    Transaction_ID SERIAL PRIMARY KEY,
    User_Name VARCHAR(100),
    Age INT,
    Country VARCHAR(50),
	Product_Category VARCHAR(100),
	Purchase_Amount DECIMAL(10,2),
	Payment_Method VARCHAR(50),
	Transaction_Date DATE
);

--Importing the dataset using psql
--\copy transactions FROM 'C:/Users/mariamota/Downloads/transactions/ecommerce_transactions.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

--Average Purchase Amount
select
	count(*) as total_purchases,
	avg(purchase_amount) as average_purchase_amount,
	sum(purchase_amount) as total_revenue
from transactions

--Most Lucrative Month in 2024
select
	case
		when extract(month from transaction_date) = 1 then 'January'
		when extract(month from transaction_date) = 2 then 'February'
		when extract(month from transaction_date) = 3 then 'March'
		when extract(month from transaction_date) = 4 then 'April'
		when extract(month from transaction_date) = 5 then 'May'
		when extract(month from transaction_date) = 6 then 'June'
		when extract(month from transaction_date) = 7 then 'July'
		when extract(month from transaction_date) = 8 then 'August'
		when extract(month from transaction_date) = 9 then 'September'
		when extract(month from transaction_date) = 10 then 'October'
		when extract(month from transaction_date) = 11 then 'November'
		when extract(month from transaction_date) = 12 then 'December'
	end as month,
	count(purchase_amount) as number_of_purchases,
	sum(purchase_amount) as revenue
from transactions
where extract(year from transaction_date) = 2024
group by month
order by revenue desc

--Most Lucrative Product Category
select
	product_category,
	count(purchase_amount) as number_of_purchases,
	sum(purchase_amount) as revenue,
	avg(purchase_amount) as average_purchase_amount
from transactions
group by product_category
order by revenue desc

--Most lucrative product by month
with (
	select
		case
			when extract(month from transaction_date) = 1 then 'January'
			when extract(month from transaction_date) = 2 then 'February'
			when extract(month from transaction_date) = 3 then 'March'
			when extract(month from transaction_date) = 4 then 'April'
			when extract(month from transaction_date) = 5 then 'May'
			when extract(month from transaction_date) = 6 then 'June'
			when extract(month from transaction_date) = 7 then 'July'
			when extract(month from transaction_date) = 8 then 'August'
			when extract(month from transaction_date) = 9 then 'September'
			when extract(month from transaction_date) = 10 then 'October'
			when extract(month from transaction_date) = 11 then 'November'
			when extract(month from transaction_date) = 12 then 'December'
		end as month,
		count(purchase_amount) as number_of_purchases,
		sum(purchase_amount) as revenue
	from transactions
	where extract(year from transaction_date) = 2024
	group by month
	order by revenue desc
)

with (
	select
		product_category,
		count(purchase_amount) as number_of_purchases,
		sum(purchase_amount) as revenue,
		avg(purchase_amount) as average_purchase_amount
	from transactions
	group by product_category
	order by revenue desc
)


--Age Group analysis
select
	case
		when age < 20 then '0-20'
		when age < 40 then '20-40'
		when age < 60 then '40-60'
		when age < 80 then '60-80'
		else '80+'
	end as age_group,
	count(purchase_amount) as number_of_purchases,
	sum(purchase_amount) as revenue
from transactions
group by age_group
order by revenue desc

--Country analysis
select
	country,
	count(purchase_amount) as number_of_purchases,
	sum(purchase_amount) as revenue
from transactions
group by country
order by revenue desc

--Payment methods
select
	payment_method,
	count(*) as number_of_payments,
	sum(purchase_amount) as revenue
from transactions
group by payment_method
order by number_of_payments desc

select * from transactions
