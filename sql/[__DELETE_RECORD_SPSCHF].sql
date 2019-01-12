USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__DELETE_RECORD_SPSCHF]    Script Date: 22.07.2016 13:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__DELETE_RECORD_SPSCHF](@NREC binary(8))
AS
BEGIN
	
	create table #xx$locks (TableNRec binary(8)) 
	
	DELETE FROM t$SPSCHF  
	WHERE f$CSCHFACT = @NREC;  
	
	drop table #xx$locks

END
