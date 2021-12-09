USE WideWorldImporters
GO
IF EXISTS(
	SELECT 1
	FROM sys.indexes si
	WHERE
		si.name = 'IX_Sales_Invoices_LastEditedWhen'
)
BEGIN
	DROP INDEX IX_Sales_Invoices_LastEditedWhen ON Sales.Invoices;
END;
GO
IF NOT EXISTS(
	SELECT 1
	FROM sys.indexes si
	WHERE
		si.name = 'IX_Sales_Invoices_LastEditedWhen'
)
BEGIN
	CREATE INDEX IX_Sales_Invoices_LastEditedWhen 
		ON Sales.Invoices (LastEditedWhen)
		INCLUDE (DeliveryInstructions)
		--WHERE (DeliveryInstructions IS NOT NULL);
END;
GO
