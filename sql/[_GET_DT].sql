USE [Data_zl3]
GO
/****** Object:  UserDefinedFunction [dbo].[_GET_DT]    Script Date: 18.07.2016 12:12:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[_GET_DT](@date int, @time int)
RETURNS DATETIME
 BEGIN
  RETURN CONVERT(DATETIME,
         CONVERT(VARCHAR(4),dbo.dtYear(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+'-'+
         CONVERT(VARCHAR(2),dbo.dtMonth(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+'-'+
         CONVERT(VARCHAR(2),dbo.dtDay(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+' '+
         CONVERT(VARCHAR(2),dbo.dtHour(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+':'+
         CONVERT(VARCHAR(2),dbo.dtMinute(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+':'+
         CONVERT(VARCHAR(2),dbo.dtSecond(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time)))+'.'+
         CONVERT(VARCHAR(2),dbo.dtSec100(CONVERT(BINARY(4),@date|0x80000000)+CONVERT(BINARY(4), @time))),121)      
 END

 