USE WideWorldImporters
GO
SET NOCOUNT OFF;

--	Note the different syntax for a IMOLTP table
--ALTER TABLE [Warehouse].[VehicleTemperatures]
--	ADD INDEX IX_VehicleTemperatures_RecordedWhen NONCLUSTERED (RecordedWhen);

DECLARE 
	@BatchSize INT = 100,
	@Duration INT = 5,
	@EndTime DATETIME2(3);

SET @EndTime = DATEADD(SECOND, @Duration, GETUTCDATE());

BEGIN TRANSACTION;

WHILE (GETUTCDATE() < @EndTime)
BEGIN
	--620528 rows
	DELETE TOP (@BatchSize) vt
	FROM Warehouse.VehicleTemperatures vt
	WHERE
		vt.RecordedWhen < DATEADD(DAY, -180, GETUTCDATE());

	IF (@@ROWCOUNT = 0)
	BEGIN
		BREAK;
	END;
END;

ROLLBACK TRANSACTION;
GO
