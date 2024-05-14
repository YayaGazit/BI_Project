---------------------STG---------------------

--TRUNCATE TABLE MAS_stg.dbo.STG_CUSTOMERS
CREATE TABLE MAS_stg.dbo.STG_CUSTOMERS (
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


--TRUNCATE TABLE MAS_stg.dbo.STG_PRODUCTS
CREATE	TABLE MAS_stg.dbo.STG_PRODUCTS (
	DW_Product Int identity(1,1),
	Catalog_Number Varchar(60),
	Product_Detail Varchar(100),
	Price Money,
)


--TRUNCATE TABLE MAS_stg.dbo.STG_ORDER_DETAILS
CREATE	TABLE MAS_stg.dbo.STG_ORDER_DETAILS ( /*פרטני למוצר*/
	DW_Order_Detail Int identity(1,1),
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

---------------------DROPS---------------------
DROP TABLE MAS_stg.dbo.STG_ORDER_DETAILS
DROP TABLE MAS_stg.dbo.STG_PRODUCTS
DROP TABLE MAS_stg.dbo.STG_CUSTOMERS

