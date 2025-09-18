select *
from online_retail
limit 10;


-- Running tally of items sold up to each day
WITH daily_sales AS (
  SELECT DATE(InvoiceDate) AS SaleDate, SUM(Quantity) AS ItemsSold
  FROM online_retail
  GROUP BY DATE(InvoiceDate)
)
SELECT
  SaleDate,
  ItemsSold,
  SUM(ItemsSold) OVER (ORDER BY SaleDate) AS RunningTotal
FROM daily_sales
ORDER BY SaleDate;


##From here down is what made the website

-- Running tally of total sales (sum of UnitPrice * Quantity) up to each day
WITH daily_sales_value AS (
  SELECT DATE(InvoiceDate) AS SaleDate, SUM(UnitPrice * Quantity) AS TotalSales
  FROM online_retail
  GROUP BY DATE(InvoiceDate)
)
SELECT
  SaleDate,
  TotalSales,
  SUM(TotalSales) OVER (ORDER BY SaleDate) AS RunningTotalSales
FROM daily_sales_value
ORDER BY SaleDate;


-- Top countries by total items bought
SELECT 
  Country, 
  SUM(Quantity) AS TotalItemsSold,
  RANK() OVER (ORDER BY SUM(Quantity) DESC) AS CountryRank
FROM online_retail
GROUP BY Country
ORDER BY TotalItemsSold DESC;

