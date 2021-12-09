USE WideWorldImporters
GO
SET NOCOUNT ON;

DECLARE 
	@BatchSize INT = 1000,
	@RowsUpdated INT = 0,
	@Max INT = 50000;

BEGIN TRANSACTION;

WHILE (@RowsUpdated < @Max)
BEGIN
	UPDATE TOP (@BatchSize) inv
	SET 
		inv.DeliveryInstructions = NULL
	FROM Sales.Invoices inv
	WHERE
		inv.LastEditedWhen < DATEADD(DAY, -90, GETUTCDATE())
		AND inv.DeliveryInstructions IS NOT NULL;

	SET @RowsUpdated += @@ROWCOUNT;
END;

	--Testing our last batch execution

	--UPDATE TOP (@BatchSize) inv
	--SET 
	--	inv.DeliveryInstructions = NULL
	--FROM Sales.Invoices inv
	--WHERE
	--	inv.LastEditedWhen < DATEADD(DAY, -90, GETUTCDATE())
	--	AND inv.DeliveryInstructions IS NOT NULL;

--ROLLBACK TRANSACTION;
GO
