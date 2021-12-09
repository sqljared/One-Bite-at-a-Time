USE WideWorldImporters
GO
SELECT TOP 100 
	sol.OrderID, 
	sol.UnitPrice,
	sol.Description
FROM Sales.OrderLines sol 
WHERE 
	sol.OrderID < 1000 
	AND sol.Quantity > 5
ORDER BY sol.OrderID;
GO

