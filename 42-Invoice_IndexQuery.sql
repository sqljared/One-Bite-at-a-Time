USE WideWorldImporters
GO

SELECT TOP 1000
	inv.InvoiceID,
	inv.DeliveryInstructions
FROM Sales.Invoices inv
WHERE
	inv.LastEditedWhen < DATEADD(DAY, -90, GETUTCDATE())
	AND inv.DeliveryInstructions IS NOT NULL;
GO
