USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__DELETE_RECORD_SPSOPR]    Script Date: 18.07.2016 12:11:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__DELETE_RECORD_SPSOPR](@_targetnrec nvarchar(18))
AS
BEGIN
	create table #xx$locks (TableNRec binary(8)) 
	
	declare @_NREC binary(8)
	SET @_NREC =  dbo._NVARCHAR_TO_BD(@_targetnrec)

	DELETE FROM t$spsopr  
	WHERE f$csopr = @_NREC;  
	
	drop table #xx$locks

END
