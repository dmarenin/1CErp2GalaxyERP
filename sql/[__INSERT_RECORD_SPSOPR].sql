USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__INSERT_RECORD_SPSOPR]    Script Date: 18.07.2016 12:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__INSERT_RECORD_SPSOPR](
					
					@npp int,					@pr int,					@_mcusl nvarchar(18),		@_cotped nvarchar(18),		@_party nvarchar(18),
					@kol decimal(31,15),		@cena decimal(31,15),		@stavka decimal(31,15),		@cenav decimal(31,15),		@nalogv decimal(31,15),
					@_cnalog nvarchar(18),		@_kval nvarchar(18),		@_NRECKATSOPR nvarchar(18),	@dsopr datetime,			@vhod int, 
					@summanal decimal(31,15),	@summanalv decimal(31,15)
					
											)
AS
BEGIN
set nocount on

declare @mcusl binary(8), @cotped binary(8), @party binary(8), @NRECKATSOPR binary(8)
set @mcusl = dbo._NVARCHAR_TO_BD(@_mcusl)
set @cotped = dbo._NVARCHAR_TO_BD(@_cotped)
set @party = dbo._NVARCHAR_TO_BD(@_party)
set @NRECKATSOPR = dbo._NVARCHAR_TO_BD(@_NRECKATSOPR)

declare @cgrnal binary(8)
declare @cnalog binary(8)
set @cgrnal = dbo._NVARCHAR_TO_BD(@_cnalog)

declare @tableid int
set @tableid = 1110

declare @kval binary(8) 
set @kval = dbo._NVARCHAR_TO_BD(@_kval)

declare @_NREC binary(8)
SET @_NREC =  dbo._GET_NEWNREC(@tableid)

declare @intdsopr int
set @intdsopr = dbo.toatldate(@dsopr) 

/*set @summanal = @summanal+
case when @vhod = 1 then @kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end */

insert into t$spsopr(f$nrec, f$npp, f$prmc, f$cmcusl, f$cotped, f$cparty, f$cval, f$kolfact, f$price,
f$csopr, f$dsopr, f$vidsopr, f$cgrnal, f$sumnds, f$kol, f$kolopl, f$rprice, f$vprice, f$rvprice, f$sumvnds)

values(@_NREC, @npp, @pr, @mcusl, @cotped, @party, @kval, @kol, @cena, @NRECKATSOPR, @intdsopr, 101,
@cgrnal, case when @vhod = 1 then @kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end, @kol,
@kol, @cena, case when @kval = 0x80000000000000 then @cena else @cenav end,
case when @kval = 0x80000000000000 then @cena else @cenav end,
case when @kval = 0x80000000000000 then case when @vhod = 1 then @kol*@cena*@stavka/(1+@stavka)
else @kol*@cena*@stavka end else @nalogv end)

insert into v$spdocnal(f$cspdoc, f$cdoc, f$tipdoc, f$cgrnal, f$nalog, f$summa, f$sumnal, f$cnalog,
f$sumval)
values(@_NREC, @NRECKATSOPR, 101, @cgrnal, @stavka*100, case when @vhod = 1 then
@kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end, case when @vhod = 1 then
@kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end, @cnalog,
case when @kval = 0x80000000000000 then case when @vhod = 1 then
@kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end else @nalogv end)

/*update t$katsopr
set f$snalogs = @summanal,
f$svnalogs = case when @kval = 0x80000000000000 then @summanal else @summanalv end
where f$nrec = @NRECKATSOPR*/ 

END