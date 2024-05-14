---------------------OLTP---------------------

CREATE TABLE MAS.dbo.CUSTOMERS (
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

CREATE TABLE MAS.dbo.CUSTOMER_ORDERS (
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
CONSTRAINT PK_CUSTOMER_ORDERS PRIMARY KEY (Order_ID),
CONSTRAINT FK_CUSTOMER_ORDERS FOREIGN KEY (Customer_ID)
REFERENCES CUSTOMERS (Customer_ID)
)

CREATE TABLE MAS.dbo.PRODUCTS (
Catalog_Number Varchar(60) not null,
Product_Detail Varchar(100) not null,
Price Money,
CONSTRAINT PK_PRODUCTS PRIMARY KEY (Catalog_Number,Product_Detail)
)

CREATE TABLE MAS.dbo.ORDER_DETAILS (
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
CONSTRAINT PK_ORDER_DETAILS PRIMARY KEY (Order_ID, [Row_Number]),
CONSTRAINT FK_ORDER_DETAILS1 FOREIGN KEY (Order_ID)
REFERENCES CUSTOMER_ORDERS (Order_ID),
CONSTRAINT FK_ORDER_DETAILS2 FOREIGN KEY (Catalog_Number,Product_Detail)
REFERENCES PRODUCTS (Catalog_Number, Product_Detail)
)


---------------------DROPS---------------------
DROP TABLE MAS.dbo.ORDER_DETAILS
DROP TABLE MAS.dbo.PRODUCTS
DROP TABLE MAS.dbo.CUSTOMER_ORDERS
DROP TABLE MAS.dbo.CUSTOMERS
