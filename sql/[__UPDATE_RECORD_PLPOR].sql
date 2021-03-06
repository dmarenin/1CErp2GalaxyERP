USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__UPDATE_RECORD_PLPOR]    Script Date: 18.07.2016 12:12:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__UPDATE_RECORD_PLPOR](
					
					@tipdok int,				@_cpol nvarchar(18),		@_cbankpol nvarchar(18), 
					@datob datetime,			@datvip datetime,			@numer varchar(100),
					@sumnde decimal(31,15),		@sumv decimal(31,15),		@_kval nvarchar(18),
					@_nazn nvarchar(255),		@_cplatza nvarchar(18),		@_cplat nvarchar(18),
					@_cbankplat nvarchar(18),	@id1C nvarchar(36),			@_atr nvarchar(18),
					@_targetnrec nvarchar(18),  @DESGR nvarchar(4)
											)
	
AS
BEGIN

	SET NOCOUNT ON;
	
declare @_NREC binary(8)
SET @_NREC =  dbo._NVARCHAR_TO_BD(@_targetnrec)  

declare @tipdok2 int
set @tipdok2 = @tipdok

declare @cplatza binary(8), @cplat binary(8), @cbankplat binary(8)

set @cplatza = dbo._NVARCHAR_TO_BD(@_cplatza)     
set @cplat = dbo._NVARCHAR_TO_BD(@_cplat)
set @cbankplat = dbo._NVARCHAR_TO_BD(@_cbankplat)      

declare @cpol binary(8), @cbankpol binary(8)
set @cpol = dbo._NVARCHAR_TO_BD(@_cpol)     
set @cbankpol = dbo._NVARCHAR_TO_BD(@_cbankpol)     

set @tipdok2 = (select top 1 t$usersdoc.f$tipusers
                from t$usersdoc
                inner join t$cashbank on t$usersdoc.f$ccashbank = t$cashbank.f$nrec and
                t$cashbank.f$cpodr = @cbankpol and t$cashbank.f$razdel = 2
                where t$usersdoc.f$tipgal = @tipdok)
				
declare @intdatob int
set @intdatob = dbo.toatldate(@datob)

declare @intdatvip int
set @intdatvip = dbo.toatldate(@datvip)

declare @kval binary(8)
set @kval = dbo._NVARCHAR_TO_BD(@_kval) 

declare @nazn1 varchar(100), @nazn2 varchar(100), @nazn3 varchar(55) 
set @nazn1 = substring(@_nazn, 1, 100)
set @nazn2 = substring(@_nazn, 101, 100)
set @nazn3 = substring(@_nazn, 201, 55)

update t$PLPOR
set 
f$nrec = @_NREC,
f$tidkgal = @tipdok,
f$tidk = @tipdok2,
f$datob = @intdatob,
f$nodok = @numer,
f$sumplat = @sumnde,
f$direct = 1,
f$datvip = @intdatvip, 
f$yeardoc = year(@datvip),
f$cplatnew = @cplatza,
f$cval = @kval,
f$sumplatv = @sumv,
f$modedoc = 1024,
f$namepl1 = @nazn1,
f$namepl2 = @nazn2,
f$namepl3 = @nazn3,
f$cplat = @cplat,
f$cbankplat = @cbankplat,
f$cpol = @cpol,
f$cbankpol = @cbankpol,
f$DESGR = @DESGR

where f$nrec = @_NREC

END
