USE WideWorldImporters
GO
SELECT TOP 100 
	sol.OrderLineID, 
	sol.UnitPrice 
FROM Sales.OrderLines sol 
WHERE sol.OrderLineID < 1000 
	AND sol.UnitPrice > 50;
GO
