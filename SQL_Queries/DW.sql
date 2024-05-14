---------------------DW---------------------

--DROP 	TABLE MAS_dw.dbo.DIM_CUSTOMERS
--TRUNCATE TABLE MAS_dw.dbo.DIM_CUSTOMERS
CREATE	TABLE MAS_dw.dbo.DIM_CUSTOMERS (
	Customer_ID Varchar(20),
	Customer_Name Varchar(60),
	[Status] Varchar(20),		
	[Start_Date] Date,
	[Update_Date] Date,
	City Varchar(20),
	Postal_Code Varchar(20),
	Payment_Type Varchar(40),
	Stock_Symbol Varchar(20),
	District Varchar(20)
)

--DROP 	TABLE MAS_dw.dbo.DIM_PRODUCTS
--TRUNCATE TABLE MAS_dw.dbo.DIM_PRODUCTS
CREATE TABLE MAS_dw.dbo.DIM_PRODUCTS (
	DW_Product Int,
	Catalog_Number Varchar(60),
	Product_Detail Varchar(100),
	Price Money
)

--DROP 	TABLE MAS_dw.dbo.DIM_CITIES
--TRUNCATE TABLE MAS_dw.dbo.DIM_CITIES
CREATE	TABLE MAS_dw.dbo.DIM_CITIES (
	City Varchar(20),
	District Varchar(20)
)

--DROP 	TABLE MAS_dw.dbo.DIM_DATES
CREATE	TABLE MAS_dw.dbo.DIM_DATES
(
	TheDate date,
	TheDay int,
	TheDayName varchar(20),
	TheDayOfWeek int,
	IsWeekend int,
	TheWeek int,
	TheWeekOfMonth int,
	TheMonth int,
	TheMonthName varchar(20),
	TheQuarter int,
	TheFirstOfQuarter date,
	TheLastOfQuarter date,
	TheYear int,
	IsLeapYear int
)

--DROP 	TABLE MAS_dw.dbo.DW_PUBLIC_COMPANIES
--TRUNCATE TABLE MAS_dw.dbo.DW_PUBLIC_COMPANIES
---------------------Secoundary DB---------------------
CREATE	TABLE MAS_dw.dbo.DW_PUBLIC_COMPANIES (
	Stock_Symbol Varchar(20),
	Company Varchar(100),
	[Year] Int,
	[Quarter] Int,
	Net_Profit Money,
	DW_Company Int identity(1,1)
)



--DROP 	TABLE MAS_dw.dbo.DW_ORDER_DETAILS
--TRUNCATE TABLE MAS_dw.dbo.DW_ORDER_DETAILS
CREATE	TABLE MAS_dw.dbo.DW_ORDER_DETAILS ( /*פרטני למוצר*/
	DW_Order_Detail Int,
	Order_ID Varchar(20),
	Bid_ID Varchar(30),
	[Row_Number] Int,
	Quantity Int,
	[Status] Varchar(60),
	Remains_To_Supply Int,
	Price Money,
	Pay_Date Date,
	Requested_Date Date,
	Supply_Date Date,
	Deal_By Varchar(20),
	DW_Product Int,
	Customer_ID Varchar(20),
	Discount Float,

	Payment_Condition Varchar(20),
	VAT Money,
	Profit Money,
	Cost Money,
	
	Price_After_Discount Money,
	Gap Int, /*(Requsted_Date-Supply_Date)*/
	Final_Price Money,
	Order_Date Date,
	Order_Type Varchar(20)
)



CREATE	TABLE	MAS_dw.dbo.FACT_SUMMARY_ORDERS (
	Customer_ID Varchar(20),
	[Year] Int,
	[Quarter] Int,
	Total_Profit Money,
	Total_Cost Money,
	Total_Payment Money
)

CREATE	TABLE MAS_dw.dbo.FACT_SUMMARY_PUBLIC_COMPANIES (
	Customer_ID Varchar(20),
	Stock_Symbol Varchar(20),
	Number_Of_Orders Int,
	Total_Price Money
)

create table MAS_dw.dbo.DIM_DATES
(
	TheDate date,
	TheDay int,
	TheDayName varchar(20),
	TheDayOfWeek int,
	IsWeekend int,
	TheWeek int,
	TheWeekOfMonth int,
	TheMonth int,
	TheMonthName varchar(20),
	TheQuarter int,
	TheFirstOfQuarter date,
	TheLastOfQuarter date,
	TheYear int,
	IsLeapYear int
	)


DECLARE @StartDate  date = '20100101';
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 30, @StartDate));
;WITH seq(n) AS
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
),

dim AS
(
  SELECT
    TheDate,
    TheDay,
    TheDayName,
    TheDayOfWeek,
    IsWeekend           = CASE WHEN TheDayOfWeek IN (CASE @@DATEFIRST WHEN 1 THEN 6 WHEN 7 THEN 1 END,7)
                            THEN 1 ELSE 0 END,
    TheWeek,
    TheWeekOfMonth      = CONVERT(tinyint, DENSE_RANK() OVER
                            (PARTITION BY TheYear, TheMonth ORDER BY TheWeek)),
    TheMonth,
    TheMonthName,
    TheQuarter,
    TheFirstOfQuarter   = MIN(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheLastOfQuarter    = MAX(TheDate) OVER (PARTITION BY TheYear, TheQuarter),
    TheYear,
    IsLeapYear          = CONVERT(bit, CASE WHEN (TheYear % 400 = 0)
                            OR (TheYear % 4 = 0 AND TheYear % 100 <> 0)
                            THEN 1 ELSE 0 END)
  FROM src
)
insert into MAS_dw.dbo.DIM_DATES
SELECT * FROM dim
  ORDER BY TheDate

OPTION (MAXRECURSION 0);

---------------------DROPS---------------------

DROP TABLE MAS_dw.dbo.DIM_CUSTOMERS
DROP TABLE MAS_dw.dbo.DIM_PRODUCTS
DROP TABLE MAS_dw.dbo.DIM_CITIES
DROP TABLE MAS_dw.dbo.DW_PUBLIC_COMPANIES
DROP TABLE MAS_dw.dbo.DW_ORDER_DETAILS
DROP TABLE MAS_dw.dbo.FACT_SUMMARY_ORDERS
DROP TABLE MAS_dw.dbo.FACT_SUMMARY_PUBLIC_COMPANIES
DROP TABLE MAS_dw.dbo.DIM_DATES
