USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_GET_NEWNREC]    Script Date: 18.07.2016 12:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_GET_NEWNREC](@tableid int)

RETURNS binary(8)

 BEGIN

DECLARE @newnrec binary(8), @Ofis int

SET @newnrec = 0x8000000000000000

DECLARE @F$NREC binary(8), @needmax int, @db_name varchar(30)

SET @F$NREC = 0x8000000000000000
SET @needmax = 0
SET @db_name = UPPER(DB_NAME())

SELECT @Ofis = OfficeNo FROM X$JournalConfig

IF @Ofis IS NULL SET @Ofis = 0

exec master..na_getnextnrec @db_name, @tableid, @F$NREC output, @needmax output

SET @newnrec = convert(binary(2), @Ofis|0x8000)+substring(@F$NREC, 3, 6)

  RETURN @newnrec

 END

