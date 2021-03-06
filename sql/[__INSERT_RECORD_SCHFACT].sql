USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__INSERT_RECORD_SCHFACT]    Script Date: 22.07.2016 13:20:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__INSERT_RECORD_SCHFACT]
(
@corg binary(8), /* Ссылка на контрагента */
@prstav int, /* Входимость налогов в цену (1 - да, 2 - нет) */
@cstepdoc binary(8), /* Ссылка на этап документа-основания */
@dfact datetime, /* Дата составления */
@dpost datetime, /* Дата получения от поставщика */
@numer varchar(100), /* Номер накладной */
@regdoc int, /* Регистрируемый документ (= 1?) */
@state int, /* Состояние (= 1?) */
@tipuser int, /* Код пользовательского документа (= 7300?) */
@kval binary(8), /* Ссылка на валюту */
@sumbezndsosn decimal(31,15), /* Сумма без НДС по основной ставке */
@sumbezndsdop decimal(31,15), /* Сумма без НДС по дополнительной ставке */
@sumbezndsex decimal(31,15), /* Сумма без НДС по ставке экспорта */
@sumnonds decimal(31,15), /* Сумма, не облагаемая НДС */
@sumndsosn decimal(31,15), /* Сумма НДС по основной ставке */
@sumndsdop decimal(31,15), /* Сумма НДС по дополнительной ставке */
@sumndsex decimal(31,15), /* Сумма НДС по ставке экспорта */
@imp decimal(31,15), /* Импорт */
@akz decimal(31,15), /* Акциз */
@nsp decimal(31,15), /* Налог с продаж */
@sumsndsosn decimal(31,15), /* Сумма вместе с НДС по основной ставке */
@sumsndsdop decimal(31,15), /* Сумма вместе с НДС по дополнительной ставке */
@sumsndsex decimal(31,15), /* Сумма вместе с НДС по ставке экспорта */
@sumnalnonds decimal(31,15), /* Сумма налогов, с которых не берётся НДС */
@nazn varchar(200), /* Дополнение */
@cdogovor binary(8), /* Ссылка на договор */
@cgruzfrom binary(8), /* Ссылка на грузоотправителя */
@cgruzto binary(8), /* Ссылка на грузополучателя */
@cmyacc binary(8), /* Ссылка на наш KATBANK.NREC */
@ckontracc binary(8), /* Ссылка на KATBANK.NREC контрагента */
@id1C nvarchar(36), /* Атрибут из 1С */
@catr binary(8) /* Ссылка на атрибут в Галактике */
) 
	
AS
BEGIN
set nocount on

declare @cbasedoc binary(8)
set @cbasedoc = (select f$cbasedoc
                from t$stepdoc
				where f$nrec = @cstepdoc) /* Ссылка на документ-основание */
set @cbasedoc = case when @cbasedoc is null then 0x8000000000000000 else @cbasedoc end
declare @intdpost int, @intdfact int
set @intdfact = dbo.toatldate(@dfact) /* Дата составления ("галактическая") */
set @intdpost = dbo.toatldate(@dpost) /* Дата получения от поставщика ("галактическая") */
declare @summa decimal(31,15), @summareg decimal(31,15)
set @summa = @sumsndsosn+@sumsndsdop+@sumsndsex+@sumnalnonds /* Сумма Итого */
set @summareg = @summa /* Зарегистрированная сумма */
declare @mykpp varchar(20), @myinn varchar(20), @orgkpp varchar(20), @orginn varchar(20)
set @mykpp = (select f$kodplatnds from t$katorg where f$nrec = @cgruzto) /* Наш КПП (мы - грузополучатель) */
set @myinn = (select f$unn from t$katorg where f$nrec = @cgruzto) /* Наш ИНН (мы - грузополучатель) */
set @orgkpp = (select f$kodplatnds from t$katorg where f$nrec = @corg) /* КПП организации */
set @orginn = (select f$unn from t$katorg where f$nrec = @corg) /* ИНН организации */
declare @newnrec binary(8)
SET @newnrec =  dbo._get_newnrec(3500)

insert into t$schfact(f$nrec, f$direct, f$num, f$corg, f$dfact, f$dpost, f$schyear, f$regdoc, f$state,
f$tipuser, f$cbasedoc, f$cstepdoc, f$nazn, f$sum#1#, f$sum#4#, f$sum#23#, f$sum#7#, f$sum#2#, f$sum#5#,
f$sum#8#, f$sum#3#, f$sum#6#, f$sum#9#, f$sum#10#, f$sumin#1#, f$summa, f$summareg, f$cval, 
f$cgruzfrom, f$cgruzto, f$cmyacc, f$ckontracc, f$prstav, f$ss#1#, f$ss#2#, f$ss#3#, f$ss#4#, f$sumin#2#,
f$sumin#11#)
values (@newnrec, 2, @numer, @corg, @intdfact, @intdpost, year(@dfact), @regdoc, @state, @tipuser,
@cbasedoc, @cstepdoc, @nazn, @sumbezndsosn, @sumbezndsdop, @sumbezndsex, @sumnonds, @sumndsosn,
@sumndsdop, @sumndsex, @sumsndsosn, @sumsndsdop, @sumsndsex, @sumnalnonds, @imp, @summa, @summareg,
@kval, @cgruzfrom, @cgruzto, @cmyacc, @ckontracc, @prstav, @mykpp, @orgkpp, @myinn, @orginn,
@akz, @nsp)


insert into v$attrval(f$vstring, f$wtable, f$cattrnam, f$crec) 
values (@id1c, 3500, @catr, @newnrec)

end
