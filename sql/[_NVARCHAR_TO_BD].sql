USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_NVARCHAR_TO_BD]    Script Date: 18.07.2016 12:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_NVARCHAR_TO_BD](@NREC nvarchar(18))
RETURNS binary(8)
 BEGIN
  RETURN CONVERT(binary(8), @NREC, 1)
 END

 