USE WideWorldImporters
GO
SELECT TOP 100 
	sol.OrderID, 
	sol.UnitPrice,
	sol.Description
FROM Sales.OrderLines sol WITH(INDEX(FK_Sales_OrderLines_OrderID))
WHERE 
	sol.OrderID < 1000 
	AND sol.Quantity > 5
ORDER BY sol.OrderID;
GO

