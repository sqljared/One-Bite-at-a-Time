USE WideWorldImporters
GO
SELECT TOP 100 
	sol.OrderID, 
	sol.UnitPrice,
	sol.Quantity,
	sol.PickedQuantity,
	sol.LastEditedWhen
FROM Sales.OrderLines sol 
WHERE 
	sol.OrderID < 5000 
	AND sol.Quantity > 5
ORDER BY 
	sol.LastEditedWhen;
GO

--CREATE INDEX IX_OrderLines_LastEditedWhen ON Sales.OrderLines (LastEditedWhen);
