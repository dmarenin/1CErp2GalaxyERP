USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_BD_TO_INT]    Script Date: 18.07.2016 12:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_BD_TO_INT](@NREC Binary(8))
RETURNS int
 BEGIN
  RETURN convert(int, @NREC )
 END

 