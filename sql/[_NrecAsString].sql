USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_NrecAsString]    Script Date: 18.07.2016 12:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_NrecAsString](@NREC Binary(8))
RETURNS nvarchar(18)
 BEGIN
  RETURN CONVERT(nvarchar(18), @NREC , 1)
 END

