USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__DELETE_RECORD_NrecATTRVAL]    Script Date: 18.07.2016 12:10:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__DELETE_RECORD_NrecATTRVAL](@_targetnrec nvarchar(18))


AS
BEGIN

create table #xx$locks (TableNRec binary(8)) 
	
	declare @_NREC binary(8)
	SET @_NREC =  dbo._NVARCHAR_TO_BD(@_targetnrec)

	DELETE FROM T$ATTRVAL
	WHERE F$CREC = @_NREC;  
	
	drop table #xx$locks
END

