USE [Data_zl3]
GO
/****** Object:  StoredProcedure [dbo].[__INSERT_RECORD_SPSCHF]    Script Date: 22.07.2016 13:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[__INSERT_RECORD_SPSCHF]
(
@newnrec binary(8), /* NREC СФ */
@npp int, /* Номер по порядку */
@pr int, /* Признак МЦ */
@mcusl binary(8), /* Ссылка на МЦ */
@cotped binary(8), /* Ссылка на отпускную единицу */
@party binary(8), /* Ссылка на партию */
@cgrnal binary(8), /* Ссылка на группу налогов */
@kol decimal(31,15), /* Количество по позиции */
@cena decimal(31,15), /* Цена (графа 4 СФ) */
@akcizpr decimal(31,15), /* Акциз в цене (графа 5 СФ) */
@drnal decimal(31,15), /* Другие налоги */
@nalsp decimal(31,15), /* Сумма налога с продаж */
@dfact datetime, /* Дата составления */
@kval binary(8), /* Ссылка на валюту */
@prstav int /* Входимость налогов в цену (1 - да, 2 - нет) */
)
AS
BEGIN
set nocount on

declare @name varchar(80)
set @name = case when @pr = 1 then (select f$name
                                    from t$katmc
                                    where f$nrec = @mcusl)
            else (select f$name
                  from t$katusl
                  where f$nrec = @mcusl)
            end /* Наименование позиции */
declare @intdfact int
set @intdfact = dbo.toatldate(@dfact) /* Дата составления ("галактическая") */
declare @stavka decimal(31,15)
set @stavka = (select top 1 f$nalog
from t$spgrnal
where @intdfact >= f$nald1 and @intdfact <= f$nald2 and f$cgrnal = @cgrnal)/100 /* Ставка налога */
declare @newnrec2 binary(8)
SET @newnrec2 =  dbo._get_newnrec(3502) /* Новый NREC спецификации СФ */
declare @cenav decimal(31,15), @cenavbez decimal(31,15), @vakcizpr decimal(31,15)
declare @vnds decimal(31,15), @vdrnal decimal(31,15), @vnalsp decimal(31,15)
set @cenav = 0 /* Графа 4 СФ (Цена за единицу) вал */
set @cenavbez = 0 /* Цена за единицу без НДС вал */
set @vakcizpr = 0 /* Графа 5 СФ (Акциз в цене) вал */
set @vnds = 0 /* Графа 9 СФ (Сумма НДС по позиции) вал */
set @vdrnal = 0 /* Сумма других налогов вал */
set @vnalsp = 0 /* Сумма налога с продаж вал */

insert into t$spschf(f$nrec, f$numpos, f$prmc, f$cmcusl, f$cotped, f$cparty, f$cval, f$kolopl, f$price,
f$cschfact, f$cgrnal, f$prnonds, f$akcizpr, f$sum, f$akcizsum, f$percnds, f$nds, f$drnal, f$sumall,
f$vprice, f$vprnonds, f$vakcizpr, f$vsum, f$vakcizsum, f$vnds, f$vdrnal, f$vsumall, f$fs#1#, f$fs#2#,
f$fs#3#, f$fs#4#, f$name)
values(@newnrec2, @npp, @pr, @mcusl, @cotped, @party, @kval, @kol, @cena, @newnrec, @cgrnal,
case when @prstav = 1 then @cena/(1+@stavka) else @cena end, @akcizpr, @kol*@cena, @kol*@akcizpr,
@stavka*100, case when @prstav = 1 then @kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end,
@drnal, @kol*@cena+@kol*@akcizpr+(case when @prstav = 1 then @kol*@cena*@stavka/(1+@stavka)
else @kol*@cena*@stavka end)+@drnal, case when @kval = 0x80000000000000 then @cena else @cenav end,
case when @kval = 0x80000000000000 then case when @prstav = 1 then @cena/(1+@stavka) else @cena end
else @cenavbez end, case when @kval = 0x80000000000000 then @akcizpr else @vakcizpr end, case when
@kval = 0x80000000000000 then @kol*@cena else @kol*@cenav end, case when @kval = 0x80000000000000
then @kol*@akcizpr else @kol*@vakcizpr end, case when @kval = 0x80000000000000 then case when @prstav = 1
then @kol*@cena*@stavka/(1+@stavka) else @kol*@cena*@stavka end else @vnds end, case when
@kval = 0x80000000000000 then @drnal else @vdrnal end, case when @kval = 0x80000000000000 then
@kol*@cena+@kol*@akcizpr+(case when @prstav = 1 then @kol*@cena*@stavka/(1+@stavka)
else @kol*@cena*@stavka end)+@drnal else @kol*@cenav+@kol*@vakcizpr+@vnds+@drnal end, @nalsp, case when
@kval = 0x80000000000000 then @nalsp else @vnalsp end, @cena, @cena, @name)

END
