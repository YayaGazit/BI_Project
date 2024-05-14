---------------------MRR---------------------

--TRUNCATE TABLE MAS_mrr.dbo.MRR_CUSTOMERS
CREATE TABLE MAS_mrr.dbo.MRR_CUSTOMERS (
Customer_ID Varchar(20) not null,
Customer_Name Varchar(60),
[Status] Varchar(20),		
[Start_Date] Date,
[Update_Date] Date,
City Varchar(20),
Postal_Code Varchar(20),
Payment_Type Varchar(40),
Stock_Symbol Varchar(20),
CONSTRAINT PK_CUSTOMERS PRIMARY KEY (Customer_ID)
)

--TRUNCATE TABLE MAS_mrr.dbo.MRR_CUSTOMER_ORDERS
CREATE TABLE MAS_mrr.dbo.MRR_CUSTOMER_ORDERS (
Order_ID Varchar(20) not null,
Bid_ID Varchar(30),
Customer_ID Varchar(20),		
[Order_Date] Date,
Order_Status Varchar(40),
Closed Bit,
Total_Quantity Int,
Update_Status_Date Date,
Order_Type Varchar(20),
Price Money,
Discount Float,
Price_After_Discount Money,
VAT Money,
Final_Price Money,
Cost Money,
Profit Money,
Profit_Percentage Float,
Payment_Condition Varchar(20),
Deal_By Varchar(20),
CONSTRAINT PK_CUSTOMER_ORDERS PRIMARY KEY (Order_ID)
)

--TRUNCATE TABLE MAS_mrr.dbo.MRR_PRODUCTS
CREATE TABLE MAS_mrr.dbo.MRR_PRODUCTS (
Catalog_Number Varchar(60) not null,
Product_Detail Varchar(100) not null,
Price Money,
CONSTRAINT PK_PRODUCTS PRIMARY KEY (Catalog_Number,Product_Detail)
)

--TRUNCATE TABLE MAS_mrr.dbo.MRR_ORDER_DETAILS
CREATE TABLE MAS_mrr.dbo.MRR_ORDER_DETAILS (
Order_ID Varchar(20) not null,
[Row_Number] Int,
Catalog_Number Varchar(60),
Product_Detail Varchar(100),
Quantity Int,
[Status] Varchar(60),
Remains_To_Supply Int,
Pay_Date Date,
Requested_Date Date,
Supply_Date Date,
Total_Price Money,
CONSTRAINT PK_ORDER_DETAILS PRIMARY KEY (Order_ID, [Row_Number])
)

---------------------DROPS---------------------
DROP TABLE MAS_mrr.dbo.MRR_ORDER_DETAILS
DROP TABLE MAS_mrr.dbo.MRR_PRODUCTS
DROP TABLE MAS_mrr.dbo.MRR_CUSTOMER_ORDERS
DROP TABLE MAS_mrr.dbo.MRR_CUSTOMERS