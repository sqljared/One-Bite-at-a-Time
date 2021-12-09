USE WideWorldImporters
GO
SELECT TOP 100 
	so.OrderID, 
	so.CustomerID,
	sol.Quantity,
	sol.PickedQuantity,
	sol.LastEditedWhen
FROM Sales.Orders so
--INNER HASH 
JOIN Sales.OrderLines sol 
	ON so.OrderID = sol.OrderID
WHERE 
	sol.OrderID < 5000 
	AND sol.Quantity > 5
--ORDER BY sol.LastEditedWhen
GO
