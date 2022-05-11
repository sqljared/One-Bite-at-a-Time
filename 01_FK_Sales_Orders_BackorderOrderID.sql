USE [WideWorldImporters]
GO
--There is an FK relationship here that isn't normally indexed!
IF NOT EXISTS(
	SELECT 1
	FROM sys.indexes si
	WHERE
		si.name = 'IX_Sales_Orders_BackorderOrderID'
)
BEGIN
	CREATE NONCLUSTERED INDEX [IX_Sales_Orders_BackorderOrderID] ON [Sales].[Orders]
	(
		[BackorderOrderID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, 
	ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA];
END;
GO

