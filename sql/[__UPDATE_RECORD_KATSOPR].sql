USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__UPDATE_RECORD_KATSOPR]    Script Date: 18.07.2016 12:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__UPDATE_RECORD_KATSOPR](											
					
					@_ckontr nvarchar(18),		@_vhod int,					@dsopr datetime,				@numer varchar(100),		@sumnde decimal(31,15),
					@sumv decimal(31,15),		@summanal decimal(31,15),	@summanalv decimal(31,15),		@_kval nvarchar(18),		@name varchar(255),
					@_cdogovor nvarchar(18),	@_cpodrto nvarchar(18),		@_cmolto nvarchar(18),			@_cgruzfrom nvarchar(18),	@_cgruzto nvarchar(18),
					@id1C nvarchar(36),			@_atr nvarchar(18),			@_targetnrec nvarchar(18),		@DESGR nvarchar(4),			@vidsopr int
					) 
AS
BEGIN

	SET NOCOUNT ON;

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
SET @_NREC =  dbo._NVARCHAR_TO_BD(@_targetnrec)

update t$katsopr
set 

f$nrec = @_NREC,
f$vidsopr = @vidsopr,
f$nsopr = @numer, 
f$corg = @ckontr,
f$corgbase = @ckontr,
f$dsopr = @intdsopr,
f$dopr = @intdopr, 
f$vhodnal = @vhod,
f$cschfact = @csf, 
f$cstepdoc = @cstepdoc,
f$summa = @sumnde,
f$sdover = @sdover, 
f$ndover = @ndover, 
f$ddover = @intddover, 
f$name = @name,
f$cval = @kval,
f$sumval = @sumv,
f$cdogovor = @cdogovor,
f$tipsopr = 1, 
f$yearsopr = year(@dsopr), 
f$cpodrto = @cpodrto, 
f$cmolto = @cmolto,
f$cgruzfrom = @cgruzfrom,
f$cgruzto = @cgruzto,
f$cvalut = @kval,
f$dprice = @intdprice,
f$SNALOGS = @summanal,
f$DESGR = @DESGR

where f$nrec = @_NREC

END
