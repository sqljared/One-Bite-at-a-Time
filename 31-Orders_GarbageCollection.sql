USE WideWorldImporters
GO
CREATE OR ALTER PROCEDURE Sales.Orders_GarbageCollection(
@BatchSize INT = 100,
@Duration INT = 30
)AS
SET NOCOUNT ON;

	DECLARE 
		@NestedTransaction BIT = 0,
		@EndTime DATETIME;

	CREATE TABLE #OrdersGC(
		OrderID INT,
		INDEX IX_OrdersGC(OrderID)
	);

	CREATE TABLE #InvoicesGC(
		InvoiceID INT,
		INDEX IX_InvoicesGC(InvoiceID)
	);

	SET @EndTime = DATEADD(SECOND, @Duration, GETUTCDATE());

	WHILE (GETUTCDATE() < @EndTime)
	BEGIN
		TRUNCATE TABLE #OrdersGC;
		TRUNCATE TABLE #InvoicesGC;

		IF @@NESTLEVEL > 0
		BEGIN
			SET @NestedTransaction = 1;
		END
		ELSE
		BEGIN
			BEGIN TRANSACTION;
		END;

		INSERT INTO #OrdersGC
		SELECT TOP (@BatchSize)
			so.OrderID
		FROM Sales.Orders so
		WHERE
			so.OrderDate < 
				DATEADD(month, -50, GETUTCDATE());

		DELETE sol
		FROM #OrdersGC gc
		JOIN Sales.OrderLines sol
			ON sol.OrderID = gc.OrderID;
	
		INSERT INTO #InvoicesGC
		SELECT --TOP (@BatchSize)
			inv.InvoiceID
		FROM #OrdersGC gc
		JOIN Sales.Invoices inv
			ON inv.OrderID = gc.OrderID;


			DELETE ctr
			FROM #InvoicesGC inv
			JOIN Sales.CustomerTransactions ctr
				ON ctr.InvoiceID = inv.InvoiceID;

			DELETE sti
			FROM #InvoicesGC inv
			JOIN Warehouse.StockItemTransactions sti
				ON sti.InvoiceID = inv.InvoiceID;

			DELETE invl
			FROM #InvoicesGC inv
			JOIN sales.InvoiceLines invl
				ON invl.InvoiceID = inv.InvoiceID;

		DELETE inv
		FROM #OrdersGC gc
		JOIN Sales.Invoices inv
			ON inv.OrderID = gc.OrderID;

		DELETE so
		FROM #OrdersGC gc
		JOIN Sales.Orders so
			ON so.OrderID = gc.OrderID;
		
		IF @NestedTransaction = 0
		BEGIN
			COMMIT TRANSACTION;
		END;

	END;

GO

BEGIN TRANSACTION

EXEC Sales.Orders_GarbageCollection
	@BatchSize = 100,
	@Duration = 5;

ROLLBACK TRANSACTION
GO


--CREATE INDEX IX_Sales_Orders_OrderDate ON Sales.Orders (OrderDate);
