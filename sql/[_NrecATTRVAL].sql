USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_NrecATTRVAL]    Script Date: 18.07.2016 12:12:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_NrecATTRVAL](@_ATTRVAL nvarchar(18), @id1c nvarchar(36))
RETURNS nvarchar(18)
 BEGIN
declare  @ATTRVAL binary(8)
set @ATTRVAL =  dbo._NVARCHAR_TO_BD(@_ATTRVAL) 
declare @CREC binary(8)
 set @CREC = (
 
			SELECT  TOP 1
				[F$CREC] 
			FROM [Data_zl3].[dbo].[T$ATTRVAL]  with (nolock)
			WHERE [F$CATTRNAM] = @ATTRVAL and [F$VSTRING] = @id1c
			
			)

  RETURN CONVERT(nvarchar(18), @CREC , 1)

 END

