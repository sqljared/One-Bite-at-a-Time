USE [WideWorldImporters]
GO
IF NOT EXISTS(
	SELECT 1
	FROM sys.indexes si
	WHERE
		si.name = 'IX_VehicleTemperatures_RecordedWhen'
)
BEGIN
	ALTER TABLE [Warehouse].[VehicleTemperatures]
	ADD INDEX IX_VehicleTemperatures_RecordedWhen NONCLUSTERED (RecordedWhen);
END;
GO
