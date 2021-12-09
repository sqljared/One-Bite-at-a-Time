USE [master]
RESTORE DATABASE [WideWorldImporters] 
	FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\Backup\WWI-Larger.bak' 
	WITH  FILE = 1,  NOUNLOAD,  STATS = 5;
GO
