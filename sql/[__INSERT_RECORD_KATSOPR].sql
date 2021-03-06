USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__INSERT_RECORD_KATSOPR]    Script Date: 18.07.2016 12:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__INSERT_RECORD_KATSOPR](
												
					@_ckontr nvarchar(18),		@_vhod int,					@dsopr datetime,				@numer varchar(100),		@sumnde decimal(31,15),
					@sumv decimal(31,15),		@summanal decimal(24, 8),	@summanalv decimal(31,15),		@_kval nvarchar(18),		@name varchar(255),
					@_cdogovor nvarchar(18),	@_cpodrto nvarchar(18),		@_cmolto nvarchar(18),			@_cgruzfrom nvarchar(18),	@_cgruzto nvarchar(18),
					@id1C nvarchar(36),			@_atr nvarchar(18),			@DESGR nvarchar(4),				@vidsopr int
					
					) 
	
AS
BEGIN
set nocount on
/*create table #xx$locks (TableNRec binary(8))*/ 

declare @ckontr binary(8)
set @ckontr = dbo._NVARCHAR_TO_BD(@_ckontr)     

declare @vhod int
set @vhod = @_vhod

declare @csf binary(8), @cstepdoc binary(8)
set @csf = 0x8000000000000000
set @cstepdoc = 0x8000000000000000

declare @intdsopr int, @intdprice int
set @intdsopr = dbo.toatldate(@dsopr) 
set @intdprice = dbo.toatldate(@dsopr) 

declare @strdopr varchar(10), @dopr datetime, @intdopr int
set @intdopr = 0
--set @strdopr = '14/6/2016' /* Дата оприходования (строка) */
--set @dopr = convert(datetime, @strdopr, 103) /* Дата оприходования */
--set @intdopr = dbo.toatldate(@dopr) /* Дата оприходования ("галактическая") */

declare @sdover varchar(80), @ndover varchar(20)
set @sdover = '' /* Доверенное лицо */
set @ndover = '' /* Номер доверенности */

declare @strddover varchar(10), @ddover datetime, @intddover int
set @strddover = ''
set @ddover = convert(datetime, @strddover, 103)
set @intddover = dbo.toatldate(@ddover)

declare @kval binary(8)
set @kval = dbo._NVARCHAR_TO_BD(@_kval)    

declare @cdogovor binary(8)
set @cdogovor = dbo._NVARCHAR_TO_BD(@_cdogovor)

declare @cpodrto binary(8), @cmolto binary(8)
set @cpodrto = dbo._NVARCHAR_TO_BD(@_cpodrto)
set @cmolto = dbo._NVARCHAR_TO_BD(@_cmolto)

declare @cgruzfrom binary(8), @cgruzto binary(8)
set @cgruzfrom = dbo._NVARCHAR_TO_BD(@_cgruzfrom) 
set @cgruzto = dbo._NVARCHAR_TO_BD(@_cgruzto) 

declare @tableid int, @Ofis int
set @tableid = 1109

declare @_NREC binary(8)
SET @_NREC =  dbo._GET_NEWNREC(@tableid)

insert into t$katsopr(f$nrec, f$vidsopr, f$nsopr, f$corg, f$corgbase, f$dsopr, f$dopr, f$vhodnal,
f$cschfact, f$cstepdoc, f$summa, f$sdover, f$ndover, f$ddover, f$name, f$cval, f$sumval, f$cdogovor,
f$tipsopr, f$yearsopr, f$cpodrto, f$cmolto, f$cgruzfrom, f$cgruzto, f$cvalut, f$dprice, f$SNALOGS, f$DESGR)

values (@_NREC, @vidsopr, @numer, @ckontr, @ckontr, @intdsopr, @intdopr, @vhod, @csf, @cstepdoc, @sumnde,
@sdover, @ndover, @intddover, @name, @kval, @sumv, @cdogovor, 1, year(@dsopr), @cpodrto, @cmolto,
@cgruzfrom, @cgruzto, @kval, @intdprice, @summanal, @DESGR)

declare @catr binary(8)
set @catr = dbo._NVARCHAR_TO_BD(@_atr) 

insert INTO V$ATTRVAL(F$VSTRING, F$WTABLE, F$CATTRNAM, F$CREC) 
VALUES (@id1c, @tableid, @catr, @_NREC)

/*drop table #xx$locks*/

END
