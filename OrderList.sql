USE WideWorldImporters
GO
CREATE TYPE Sales.OrderList
AS TABLE(
	OrderID INT NOT NULL,
	INDEX IX_OrderList_OrderID (OrderID)
)
WITH	(MEMORY_OPTIMIZED = ON);  
GO
