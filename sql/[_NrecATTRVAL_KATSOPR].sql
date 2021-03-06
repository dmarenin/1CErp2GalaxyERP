USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_NrecATTRVAL_KATSOPR]    Script Date: 18.07.2016 12:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_NrecATTRVAL_KATSOPR](@_ATTRVAL nvarchar(18), @id1c nvarchar(36), @vidsopr int)

RETURNS nvarchar(18)
 BEGIN
declare  @ATTRVAL binary(8)
set @ATTRVAL =  dbo._NVARCHAR_TO_BD(@_ATTRVAL) 
declare @CREC binary(8)
 set @CREC = (
 
SELECT        TOP (1) T$ATTRVAL.F$CREC
FROM            T$ATTRVAL WITH (nolock) INNER JOIN
                         T$KATSOPR WITH (nolock) ON T$ATTRVAL.F$CREC = T$KATSOPR.F$NREC
WHERE        (T$ATTRVAL.F$CATTRNAM = @ATTRVAL) AND (T$ATTRVAL.F$VSTRING = @id1c) AND (T$KATSOPR.F$VIDSOPR = @vidsopr)
			
			)

  RETURN CONVERT(nvarchar(18), @CREC , 1)

 END
