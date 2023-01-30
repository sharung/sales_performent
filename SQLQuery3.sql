/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [order_id]
      ,[order_status]
      ,[customer]
      ,[order_date]
      ,[order_quantity]
      ,[sales]
      ,[discount]
      ,[discount_value]
      ,[product_category]
      ,[product_sub_category]
  FROM [sales_store].[dbo].[sales_performen]

/*
Msg 8115, Level 16, State 2, Line 1
Arithmetic overflow error converting expression to data type int.
*/
-- total penjualan tiap tahun dan jumlah order
-- convert to bigint
select distinct year(order_date), sum(cast(sales as bigint)), count(order_id) from sales_performen 
group by year(order_date)
order by 1

-- total penjualan berdasarkan sub category
select year(order_date), product_sub_category, sum(cast(sales as bigint)) sales from sales_performen
where (YEAR(order_date) between 2011 and 2012) and order_status like 'order finished'
group by year(order_date), product_sub_category
order by 1,3 desc

-- analisis efektifitas dan efisiensi dari promosi
select year(order_date) as years, sum(sales) as sales, sum(discount_value) as promotion_value, round((sum(discount_value)/sum(sales))*100, 2) burn_rate_percentage from sales_performen
where order_status = 'order finished'
group by year(order_date)
order by 1

-- menambahkan colum product_sub dan product_category
select top 5 year(order_date), product_sub_category, product_category, sum(sales), sum(discount_value), sum(discount_value)/sum(sales) from sales_performen
where year(order_date) = 2012
group by year(order_date), product_sub_category, product_category

-- customer transaction pertahun
select year(order_date), count( distinct customer) from sales_performen
where order_status = 'order finished'
group by year(order_date)
order 1




alter table sales_performen
alter column discount_value bigint

select * from sales_performen










