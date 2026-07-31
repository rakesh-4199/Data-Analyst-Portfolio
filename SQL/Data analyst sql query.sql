SELECT TOP (1000) [Row_ID]
      ,[Order_ID]
      ,[Order_Date]
      ,[Ship_Date]
      ,[Ship_Mode]
      ,[Customer_ID]
      ,[Customer_Name]
      ,[Segment]
      ,[Country]
      ,[City]
      ,[State]
      ,[Postal_Code]
      ,[Region]
      ,[Product_ID]
      ,[Category]
      ,[Sub_Category]
      ,[Product_Name]
      ,[Sales]
      ,[Quantity]
      ,[Discount]
      ,[Profit]
  FROM [SalesAnalytics].[dbo].[SampleSuperstore]


  select count(*) as totalorders
  from dbo.SampleSuperstore;

  select top 10 * 
  from dbo.SampleSuperstore;

  select sum(Sales) as totalsales
  from dbo.SampleSuperstore;

  select sum(Profit) as totalprofit
  from dbo.SampleSuperstore;

  select avg(Sales) as totalavgsales
  from dbo.SampleSuperstore;

  select min(sales) as minnimumsales,
         max(sales) as maximumsales
 from dbo.SampleSuperstore;

 select *
 from dbo.SampleSuperstore
 where Sales >1000;

 select *
 from dbo.SampleSuperstore
 where Category='Technology';

 /*Show the top 10 highest-profit orders.*/
 select top 10*
 from dbo.SampleSuperstore
 order by profit desc;

 /*Show the lowest 10 sales orders.*/
 select top 10 *
 from dbo.SampleSuperstore
 order by Sales asc;

 /*Show all unique Regions.*/
 select DISTINCT Region
 from dbo.SampleSuperstore

  /*Show all unique  category.*/
  select distinct category
  from dbo.SampleSuperstore

  /*Find customers whose names start with 'A'.*/
  select 
   customer_name
 from dbo.SampleSuperstore
 where Customer_Name LIKE 'A%';

  /*Find all products containing the word 'Chair'.*/
  select*
  from dbo.SampleSuperstore
  where Product_Name LIKE '%Chair%';


   /* Find sales between 1000 and 5000.*/
   select *
   from dbo.SampleSuperstore
   where Sales between 1000 and 5000;

    /*Show only Furniture and Technology categories.*/ 
	select *
	from dbo.SampleSuperstore
	where Category in ('Furniture','Technology');

	 /*Find the total sales for each Region.*/
	select 
	region,
	SUM (sales) as totalsales
	from dbo.SampleSuperstore
	group by Region; 

	 /*Find the total profit for each Category.*/
	 select
	 category,
	 SUM(profit) as totalprofit
	 from dbo.SampleSuperstore
	 group by Category;

	/*Find the total number of orders in each Segment..*/
	select
	segment,
	COUNT(*) as totalorders
	from dbo.SampleSuperstore
	group by Segment;

	 /*Find the total sales for each Category and display the highest sales category first.*/
	 select 
	 category,
	 sum(Sales) as totalsales
	 from dbo.SampleSuperstore
	 group by Category
	 order by totalsales desc;

 /*Show only Regions where total sales are greater than 500000.*/
 select
 region,
 SUM(sales) as totalsales
 from dbo.SampleSuperstore
 group by Region
 having SUM(sales)> 500000;

  /*Show only Categories where total profit is greater than 50000.*/
  select
  category,
  SUM(profit) as totalprofit
  from dbo.SampleSuperstore
  group by Category
  having  SUM(profit) >50000;

   /*Find the top performing Region based on total profit.*/
   select top 1
   Region,
  SUM(profit) as totalprofit
  from dbo.SampleSuperstore
  group by Region
  order by  totalprofit desc;

   
   /*Show whether an order is in Profit or Loss.*/
   select
   Sales,
   profit,
   case
     when profit >0 then 'profit'
	 else 'loss'
   end as status
   from dbo.SampleSuperstore;



    /*Show High Sales if Sales >1000 otherwise Low Sales.*/
	
	select
	Sales,
	case
	 when Sales>1000 then 'high sales'
	 else 'low sales'
	end as status
	from dbo.SampleSuperstore;

 /*Show HOW amny High Sales and Low sales if Sales >1000 otherwise Low Sales.*/
	SELECT
    CASE
        WHEN Sales > 1000 THEN 'High Sales'
        ELSE 'Low Sales'
    END AS SalesStatus,
    COUNT(*) AS TotalCount
FROM dbo.SampleSuperstore
GROUP BY
    CASE
        WHEN Sales > 1000 THEN 'High Sales'
        ELSE 'Low Sales'
    END;




 /*Find the total sales for each year.*/
 select YEAR (order_date) as year,
  SUM(sales) as totalsales
  from dbo.SampleSuperstore
  group by YEAR(Order_Date)
  order by year;


   /*Find the total sales for each month.*/
   select
   MONTH(order_date) as month,
   SUM(sales) as totalsales
   from dbo.SampleSuperstore
   group by MONTH(Order_Date)
   order by month


 /*Replace NULL values with 'Unknown'.*/
 select
 ISNULL(customer_name,'unknown') as customername
 from dbo.SampleSuperstore
 where Customer_Name ='unknown';


 /*Convert Sales into INTEGER.*/
 select
 CAST(sales as int) as totalsales
 from dbo.SampleSuperstore;

 
 /*Find the Top 3 customers based on Sales.*/
 select top 5
  customer_name,
  sales,
  ROW_NUMBER() over(order by sales desc) as  topsales
  from dbo.SampleSuperstore


  /*Find the Sales Rank of every order.*/
  select
  sales,
  rank() over(order by sales desc) as salesrank
  from dbo.SampleSuperstore;

  /*Find the Dense Rank of Sales.*/
  select
  sales,
  dense_rank() over(order by sales desc) as Denserank
  from dbo.SampleSuperstore;


  /*Find customers whose Sales are greater than the Average Sales.*/
  select
  customer_name,
  Sales
  from dbo.SampleSuperstore
  where Sales>(
  select
  AVG(sales) 
  from dbo.SampleSuperstore);



  /*Create a View for Total Sales by Region.*/
  create view totalsales as
  select
  region,
  SUM(Sales) as totalsales
  from dbo.SampleSuperstore
  group by Region;

   

  /*Create a Stored Procedure to display Total Sales.*/
   create procedure totalsalesreport as
  select
  SUM(sales) as totalsales
  from dbo.SampleSuperstore;

   alter procedure totalsalesreport as
  select
  SUM(sales) as totalsales
  from dbo.SampleSuperstore;

  exec totalsalesreport;

create procedure fulldata as
select *
from dbo.SampleSuperstore;

exec fulldata;

  /* BUSSINESS QUESTIONS.*/

  /* Which Region generates the highest Sales?*/
  select top 1
  region,
  SUM(Sales) as totalsales
  from dbo.SampleSuperstore
  group by Region
  order by totalsales desc;


  /* Which Category generates the highest Profit?*/
 select
 category,
 SUM(profit) as totalprofit
 from dbo.SampleSuperstore
 group by Category
 order by totalprofit desc;

 
 /* Who are our Top 10 Customers?*/
 select top 10
 customer_name,
 sum(Sales) as totalsales
 from dbo.SampleSuperstore
 group by Customer_Name
 order by totalsales desc;

 
  /*Which Products generate the highest Sales?*/
 select
 product_name,
 SUM(sales) as totalsales
 from dbo.SampleSuperstore
 group by Product_Name
 order by totalsales desc;


 SELECT COUNT(distinct Product_Name) AS TotalProducts
 product_name
FROM dbo.SampleSuperstore;



  /*Which Orders generated Loss?*/
  select
  Product_Name,
  Profit
  from dbo.SampleSuperstore
  where profit<0 
  order by Profit  asc;


select 
product_name,
SUM(profit) as totalprofit
from dbo.SampleSuperstore
where totalprofit >0
group by Product_Name
order by totalprofit;

  

  /*Which Month generated the highest Sales?*/
 select
 MONTH(order_date) as ordermonth,
 SUM(sales) as totalsales
 from dbo.SampleSuperstore
 group by MONTH(order_date)
 order by totalsales desc;


 
  /* Advanced Business Question*/
  
  /* Which Category has the Highest Profit Margin?*/
 select
 category,
 SUM(sales) as totalsales,
 SUM(profit) as totalprofit,
 ROUND((SUM(profit)*100.0/SUM(sales)),2) as profitmargin_percentage
 from dbo.SampleSuperstore
 group by Category
 order by totalprofit desc;


 
  /* Which Category receives the Highest Discount?*/
  select
  category,
  Round((AVG(discount)*100.0),2) as avgdiscount
  from dbo.SampleSuperstore
  group by Category
  order by avgdiscount desc;

  
  /*Which Customer generated the Highest Profit?*/
  select top 10
  customer_name,
  SUM(profit) as totalprofit
  from dbo.SampleSuperstore
  group by Customer_Name
  order by totalprofit desc;

  
  /* Which Region is performing poorly?*/
 select
 region,
 SUM(sales) as totalsales,
 SUM(profit) as totalprofit
 from dbo.SampleSuperstore
 group by Region
 order by totalprofit desc;


 
  /*Which Products are generating Loss?.*/
  select
  product_name,
  SUM(Profit) as totalloss
  from dbo.SampleSuperstore
  where profit<0
  group by Product_Name
  order by totalloss asc;


  select 
  COUNT( distinct product_name) as totalproucts
  from dbo.SampleSuperstore;


  
  /*Which Customer Segment contributes the Highest Sales?*/
 select
 Segment,
 SUM(sales) as totalsales
 from dbo.SampleSuperstore
 group by Segment
 order by totalsales desc;

 
  /*Which Month generated the Highest Profit?*/
 select
 MONTH(order_date) as Month,
 SUM(profit) as totalprofit
 from dbo.SampleSuperstore
 group by MONTH(Order_Date)
 order by  totalprofit desc;


 
  /*Which Top 10 Products should the company focus on?.*/
 select top 10
 product_name,
 SUM(sales) as totalsales,
 SUM(profit) as totalprofit
 from dbo.SampleSuperstore
 group by Product_Name
 order by totalprofit desc;
