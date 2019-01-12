﻿
Процедура ДанныеИзВнешнихИсточников(ВариантПолучения, СтруктураУсловий, Запрос, Разделитель) Экспорт
	
	Если ВариантПолучения = "dbo_T_KATUSL_RBP" Или ВариантПолучения = Неопределено Тогда 
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	""dbo_T_KATUSL_RBP"" КАК Таблица,
		|	BD_TO_NVARCHAR(dbo_T_KATUSL_RBP.F_NREC) КАК F_NREC,
		|	dbo_T_KATUSL_RBP.F_NAME,
		|	dbo_T_KATUSL_RBP.F_CSTZATR,
		|	dbo_T_KATUSL_RBP.F_KRSCHETK,
		|	dbo_T_KATUSL_RBP.F_SUBSCHK,
		|	dbo_T_KATUSL_RBP.F_ATL_LASTDATE
		|ИЗ
		|	(ВЫБРАТЬ
		|		dbo_T_KATUSL.F_NREC КАК F_NREC,
		|		dbo_T_KATUSL.F_NAME КАК F_NAME,
		|		МАКСИМУМ(dbo_T_NALREGDC.F_CSTZATR) КАК F_CSTZATR,
		|		МАКСИМУМ(dbo_T_NALREGDC.F_KRSCHETK) КАК F_KRSCHETK,
		|		МАКСИМУМ(dbo_T_NALREGDC.F_SUBSCHK) КАК F_SUBSCHK,
		|		МАКСИМУМ(dbo_T_NALREGDC.F_ATL_LASTDATE) КАК F_ATL_LASTDATE
		|	ИЗ
		|		(ВЫБРАТЬ РАЗЛИЧНЫЕ
		|			dbo_T_NALREGDC.F_NREC КАК F_NREC,
		|			dbo_T_NALREGDC.F_NODOC КАК F_NODOC,
		|			dbo_T_NALREGDC.F_DATDOC КАК F_DATDOC,
		|			ВЫБОР
		|				КОГДА dbo_T_OBOROT.F_TBLOS_1_ = 13
		|					ТОГДА dbo_T_OBOROT.F_KAUOS_1_
		|				КОГДА dbo_T_OBOROT.F_TBLOS_2_ = 13
		|					ТОГДА dbo_T_OBOROT.F_KAUOS_2_
		|				ИНАЧЕ NULL
		|			КОНЕЦ КАК F_CSTZATR,
		|			ВЫБОР
		|				КОГДА dbo_T_OBOROT.F_TBLKS_1_ = 5
		|					ТОГДА dbo_T_OBOROT.F_KAUKS_1_
		|				КОГДА dbo_T_OBOROT.F_TBLKS_2_ = 5
		|					ТОГДА dbo_T_OBOROT.F_KAUKS_2_
		|				КОГДА dbo_T_OBOROT.F_TBLKS_3_ = 5
		|					ТОГДА dbo_T_OBOROT.F_KAUKS_3_
		|				ИНАЧЕ NULL
		|			КОНЕЦ КАК F_NREC_KATUSL,
		|			dbo_T_OBOROT.F_KRSCHETK КАК F_KRSCHETK,
		|			dbo_T_OBOROT.F_SUBSCHK КАК F_SUBSCHK,
		|			dbo_T_OBOROT.F_ATL_LASTDATE КАК F_ATL_LASTDATE
		|		ИЗ
		|			ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_NALREGDC КАК dbo_T_NALREGDC
		|				ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_NALREGSP КАК dbo_T_NALREGSP
		|				ПО (dbo_T_NALREGDC.F_RSSYN = 1)
		|					И dbo_T_NALREGDC.F_NREC = dbo_T_NALREGSP.F_CNALREGDC
		|					И (dbo_T_NALREGSP.F_DATOB >= START_DATE())
		|				ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_OBOROT КАК dbo_T_OBOROT
		|				ПО (dbo_T_NALREGSP.F_TIDK = dbo_T_OBOROT.F_TIDK)
		|					И (dbo_T_NALREGSP.F_NREC = dbo_T_OBOROT.F_CSOPRDOC)
		|					И (BD_TO_NVARCHAR(dbo_T_OBOROT.F_CPLANSSCH) = ""0x8001000000000001"")) КАК dbo_T_NALREGDC
		|			ЛЕВОЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_KATUSL КАК dbo_T_KATUSL
		|			ПО dbo_T_NALREGDC.F_NREC_KATUSL = dbo_T_KATUSL.F_NREC
		|	
		|	СГРУППИРОВАТЬ ПО
		|		dbo_T_KATUSL.F_NREC,
		|		dbo_T_KATUSL.F_NAME) КАК dbo_T_KATUSL_RBP";
		
		СинхронизацияГалактикаОбщегоНазначения.ДополнитьЗапросУсловиямиПоТаблице(СтруктураУсловий, Запрос, ВариантПолучения);
		
		Запрос.Текст = Запрос.Текст + Разделитель;
		
	КонецЕсли;
	
	Если ВариантПолучения = "dbo_T_NALREGDC" Или ВариантПолучения = Неопределено Тогда 
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	""dbo_T_NALREGDC"" КАК Таблица,
		|	BD_TO_NVARCHAR(dbo_T_NALREGDC.F_NREC) КАК F_NREC,
		|	dbo_T_NALREGDC.F_NODOC,
		|	GET_DT(dbo_T_NALREGDC.F_DATDOC, 0) КАК F_DATDOC,
		|	dbo_T_NALREGDC.F_SUMPR,
		|	dbo_T_NALREGDC.F_ATL_LASTDATE
		|ИЗ
		|	(ВЫБРАТЬ
		|		dbo_T_NALREGDC.F_NREC КАК F_NREC,
		|		dbo_T_NALREGDC.F_NODOC КАК F_NODOC,
		|		dbo_T_NALREGDC.F_DATDOC КАК F_DATDOC,
		|		dbo_T_NALREGDC.F_SUMPR КАК F_SUMPR,
		|		МАКСИМУМ(dbo_T_OBOROT.F_ATL_LASTDATE) КАК F_ATL_LASTDATE
		|	ИЗ
		|		ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_NALREGDC КАК dbo_T_NALREGDC
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_NALREGSP КАК dbo_T_NALREGSP
		|			ПО (dbo_T_NALREGDC.F_RSSYN = 1)
		|				И dbo_T_NALREGDC.F_NREC = dbo_T_NALREGSP.F_CNALREGDC
		|				И (dbo_T_NALREGSP.F_DATOB >= START_DATE())
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_OBOROT КАК dbo_T_OBOROT
		|			ПО (dbo_T_NALREGSP.F_TIDK = dbo_T_OBOROT.F_TIDK)
		|				И (dbo_T_NALREGSP.F_NREC = dbo_T_OBOROT.F_CSOPRDOC)
		|				И (BD_TO_NVARCHAR(dbo_T_OBOROT.F_CPLANSSCH) = ""0x8001000000000001"")
		|	
		|	СГРУППИРОВАТЬ ПО
		|		dbo_T_NALREGDC.F_NREC,
		|		dbo_T_NALREGDC.F_NODOC,
		|		dbo_T_NALREGDC.F_DATDOC,
		|		dbo_T_NALREGDC.F_SUMPR) КАК dbo_T_NALREGDC";
		
		СинхронизацияГалактикаОбщегоНазначения.ДополнитьЗапросУсловиямиПоТаблице(СтруктураУсловий, Запрос, ВариантПолучения);
		
		Запрос.Текст = Запрос.Текст + Разделитель;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ЗаданиеПоТаблице(ИмяТаблицы, НаборПараметров) Экспорт
	
	Задание = Неопределено;
	
	Если ИмяТаблицы = "dbo_T_KATUSL_RBP" Тогда
		Задание = ФоновыеЗадания.Выполнить("СинхронизацияГалактикаРБП.ВыполнитьСозданиеСтатейРасходовРБП", НаборПараметров);
	КонецЕсли;
	
	Если ИмяТаблицы = "dbo_T_NALREGDC" Тогда
		Задание = ФоновыеЗадания.Выполнить("СинхронизацияГалактикаРБП.ВыполнитьСозданиеРБП", НаборПараметров);
	КонецЕсли;
	
	Возврат Задание;
	
КонецФункции

Процедура ВыполнитьСозданиеСтатейРасходовРБП(ТаблицаДанных, ИндексНачала, РазмерПроции, ИмяТаблицы, СтатическиеДанные, НомерПотока, БлокировкиПотоков) Экспорт
	
	Вариант = 1;
	Индекс = 0;	
	Менеджер = ПланыВидовХарактеристик.СтатьиРасходов;
	
	ГруппаРБП = ПланыВидовХарактеристик.СтатьиРасходов.НайтиПоКоду("00-000009");
	
	Попытка
		
		Для Сч = 1 По РазмерПроции Цикл
			
			ТекСтрока = СинхронизацияГалактикаОбщегоНазначения.ПолучитьСтрокуДляОбработки(ТаблицаДанных, Сч, ИндексНачала, Индекс);
			
			ОбъектДляЗаписи = СинхронизацияГалактикаОбщегоНазначения.ВыполнитьПоискОбъекта(ТекСтрока, ИмяТаблицы, Менеджер, Вариант);
			
			Если ОбъектДляЗаписи = Неопределено Тогда 
				Продолжить;
			КонецЕсли;
			
			СчетОсновнойГал = СокрЛП(ТекСтрока.F_KRSCHETK);
			СчетПолныйГал = СчетОсновнойГал + "." + СокрЛП(ТекСтрока.F_SUBSCHK);
			
			ОбъектДляЗаписи.Заполнить();
			
			ОбъектДляЗаписи.Родитель = ГруппаРБП;
			ОбъектДляЗаписи.Наименование = ТекСтрока.F_NAME;
			ОбъектДляЗаписи.ВариантРаспределенияРасходов = Перечисления.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов;
			ОбъектДляЗаписи.СчетУчета = СинхронизацияГалактикаОбщегоНазначения.ПолучитьСчет(СчетПолныйГал);
			ОбъектДляЗаписи.ВидАктива = Перечисления.ВидыАктивовДляРБП.ПрочиеВнеоборотныеАктивы;       
			ОбъектДляЗаписи.ПринятиеКналоговомуУчету = Истина;
			Если СчетОсновнойГал = "76" Тогда
				ОбъектДляЗаписи.ВидРБП = Перечисления.ВидыРБП.ПрочиеВидыСтрахования;
			Иначе
				ОбъектДляЗаписи.ВидРБП = Перечисления.ВидыРБП.Прочие;
			КонецЕсли;
			
			ОбъектДляЗаписи.СтатьяРасходов = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(ТекСтрока.F_CSTZATR, "dbo_T_STZATR", "Статья расходов", БлокировкиПотоков, НомерПотока);
			
			СинхронизацияГалактикаОбщегоНазначения.ВыполнитьЗаписьВБазуДанных(ОбъектДляЗаписи, ИмяТаблицы, ТекСтрока);
			
		КонецЦикла;
		
	Исключение
		
		ТекстОшибки = ОписаниеОшибки();
		
		РегистрыСведений.НеЗагруженныеОбъекты.ДобавитьЗаписьОНезагруженномОбъекте(ТекСтрока, ИмяТаблицы, Сч, ТекстОшибки);
		
		Стек = "ИМЯТАБЛИЦЫ: " + ИмяТаблицы + " ПОЛЕ: " + ТекСтрока.F_NREC + " Н: " +Строка(Сч) + " Е: " + Строка(РазмерПроции);
		
		СинхронизацияГалактикаОбщегоНазначения.ОповеститьОбОшибке(ТекстОшибки, Стек, ОбъектДляЗаписи);
		
	КонецПопытки;
	
КонецПроцедуры

Функция ПолучитьДанныеДляРаспределения(F_NREC)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("F_NREC", F_NREC);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	GET_DT(dbo_T_OBOROT.F_DATOB, 0) КАК F_DATOB,
	|	dbo_T_OBOROT.F_KODSPO,
	|	dbo_T_OBOROT.F_DBSCHETO,
	|	dbo_T_OBOROT.F_SUBOSSCH,
	|	dbo_T_OBOROT.F_TBLOS_1_,
	|	dbo_T_OBOROT.F_TBLOS_2_,
	|	dbo_T_OBOROT.F_KAUOS_1_,
	|	dbo_T_OBOROT.F_KAUOS_2_,
	|	dbo_T_OBOROT.F_KODSPK,
	|	dbo_T_OBOROT.F_KRSCHETK,
	|	dbo_T_OBOROT.F_SUBSCHK,
	|	dbo_T_OBOROT.F_TBLKS_1_,
	|	dbo_T_OBOROT.F_TBLKS_2_,
	|	dbo_T_OBOROT.F_TBLKS_3_,
	|	dbo_T_OBOROT.F_KAUKS_1_,
	|	dbo_T_OBOROT.F_KAUKS_2_,
	|	dbo_T_OBOROT.F_KAUKS_3_,
	|	dbo_T_OBOROT.F_SUMOB
	|ИЗ
	|	ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_NALREGSP КАК dbo_T_NALREGSP
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВнешнийИсточникДанных.ГалактикаБД.Таблица.dbo_T_OBOROT КАК dbo_T_OBOROT
	|		ПО dbo_T_NALREGSP.F_NREC = dbo_T_OBOROT.F_CSOPRDOC
	|			И dbo_T_NALREGSP.F_TIDK = dbo_T_OBOROT.F_TIDK
	|			И (dbo_T_NALREGSP.F_RSSYN = 1)
	|			И (dbo_T_OBOROT.F_DATOB >= START_DATE())
	|			И (dbo_T_OBOROT.F_CPLANSSCH = NVARCHAR_TO_BD(""0x8001000000000001""))
	|ГДЕ
	|	dbo_T_NALREGSP.F_CNALREGDC = NVARCHAR_TO_BD(&F_NREC)";
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

Процедура ВыполнитьСозданиеРБП(ТаблицаДанных, ИндексНачала, РазмерПроции, ИмяТаблицы, СтатическиеДанные, НомерПотока, БлокировкиПотоков) Экспорт
	
	Вариант = 3;
	Индекс = 0;
	Менеджер = Документы.ОперацияБух;
	
	Организация = Справочники.Организации.ПустаяСсылка();
	
	ОрганизацияЗапись = СтатическиеДанные.Найти("ОРГАНИЗАЦИЯ", "Реквизит");
	Если Не ОрганизацияЗапись = Неопределено Тогда 
		Организация = ОрганизацияЗапись.Значение;
	КонецЕсли;
	
	Попытка
		
		Для Сч = 1 По РазмерПроции Цикл
			
			ТекСтрока = СинхронизацияГалактикаОбщегоНазначения.ПолучитьСтрокуДляОбработки(ТаблицаДанных, Сч, ИндексНачала, Индекс);
			ОбъектДляЗаписи = СинхронизацияГалактикаОбщегоНазначения.ВыполнитьПоискОбъекта(ТекСтрока, ИмяТаблицы, Менеджер, Вариант);
			
			Если ОбъектДляЗаписи = Неопределено Тогда 
				Продолжить;
			КонецЕсли;
			
			ОбъектДляЗаписи.Дата = Дата(2016, 1, 1);
			ОбъектДляЗаписи.Организация = Организация;
			ОбъектДляЗаписи.УстановитьНовыйНомер();
			ОбъектДляЗаписи.Содержание = "РБП № " + ТекСтрока.F_NODOC + " от " + Формат(ТекСтрока.F_DATDOC, "ДФ=dd.MM.yyyy") + " на сумму " + Формат(ТекСтрока.F_SUMPR, "ЧРГ=' '; ЧН=0,00");
			
			СуммаОперации = 0;		
			
			ДанныеДокумента = ПолучитьДанныеДляРаспределения(ТекСтрока.F_NREC);
			
			ОбъектДляЗаписи.Движения.Хозрасчетный.Очистить();
			
			Для Каждого СтрокаДанных Из ДанныеДокумента Цикл
				
				НоваяСтрока = ОбъектДляЗаписи.Движения.Хозрасчетный.Добавить();
				НоваяСтрока.Активность = Истина;
				НоваяСтрока.Период = СтрокаДанных.F_DATOB;
				НоваяСтрока.ПодразделениеДт = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KODSPO, "dbo_T_KATPODR", "Подразделение", БлокировкиПотоков, НомерПотока);
				НоваяСтрока.СчетДт = СинхронизацияГалактикаОбщегоНазначения.ПолучитьСчет(СокрЛП(СтрокаДанных.F_DBSCHETO) + "." + СокрЛП(СтрокаДанных.F_SUBOSSCH));
				
				Если СтрокаДанных.F_TBLOS_1_ = 13 Тогда
					СтатьяЗатрат = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUOS_1_, "dbo_T_STZATR", "Статья расходов", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоДт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.СтатьиЗатрат, СтатьяЗатрат);	
				КонецЕсли;
				
				Если СтрокаДанных.F_TBLOS_2_ = 13 Тогда
					СтатьяЗатрат = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUOS_2_, "dbo_T_STZATR", "Статья расходов", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоДт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.СтатьиЗатрат, СтатьяЗатрат);	
				КонецЕсли;
				
				НоваяСтрока.ПодразделениеКт = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KODSPK, "dbo_T_KATPODR", "Подразделение", БлокировкиПотоков, НомерПотока);
				НоваяСтрока.СчетКт = СинхронизацияГалактикаОбщегоНазначения.ПолучитьСчет(СокрЛП(СтрокаДанных.F_KRSCHETK) + "." + СокрЛП(СтрокаДанных.F_SUBSCHK));
				
				Если СтрокаДанных.F_TBLKS_1_ = 1 И Не НоваяСтрока.СчетКт = ПланыСчетов.Хозрасчетный.ПрочиеРасходыБудущихПериодов Тогда
					Контрагент = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUKS_1_, "dbo_T_KATORG", "Контрагент", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоКт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Контрагенты, Контрагент);	
				КонецЕсли;
				
				Если СтрокаДанных.F_TBLKS_1_ = 5 Тогда
					СтатьяРБП = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUKS_1_, "dbo_T_KATUSL_RBP", "Статья расходов", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоКт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.РасходыБудущихПериодов, СтатьяРБП);	
				КонецЕсли;
				
				Если СтрокаДанных.F_TBLKS_2_ = 5 Тогда
					СтатьяРБП = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUKS_2_, "dbo_T_KATUSL_RBP", "Статья расходов", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоКт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.РасходыБудущихПериодов, СтатьяРБП);	
				КонецЕсли;
				
				Если СтрокаДанных.F_TBLKS_3_ = 5 Тогда
					СтатьяРБП = СинхронизацияГалактикаОбщегоНазначения.НайтиПодчиненныйОбъектПоОтбору(СтрокаДанных.F_KAUKS_3_, "dbo_T_KATUSL_RBP", "Статья расходов", БлокировкиПотоков, НомерПотока);
					НоваяСтрока.СубконтоКт.Вставить(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.РасходыБудущихПериодов, СтатьяРБП);	
				КонецЕсли;
				
				НоваяСтрока.Сумма = СтрокаДанных.F_SUMOB;
				НоваяСтрока.СуммаНУДт = СтрокаДанных.F_SUMOB;
				НоваяСтрока.СуммаНУКт = СтрокаДанных.F_SUMOB;
				
				СуммаОперации = СуммаОперации + НоваяСтрока.Сумма;
				
			КонецЦикла;
			
			ОбъектДляЗаписи.СуммаОперации = СуммаОперации;
			ОбъектДляЗаписи.Движения.Хозрасчетный.Записывать = НЕ СуммаОперации = 0;
			ОбъектДляЗаписи.ДополнительныеСвойства.Вставить("НеЗамещатьПериод", Истина);
			
			СинхронизацияГалактикаОбщегоНазначения.ВыполнитьЗаписьВБазуДанных(ОбъектДляЗаписи, ИмяТаблицы, ТекСтрока,,, Ложь);
			
		КонецЦикла;
		
	Исключение
		
		ТекстОшибки = ОписаниеОшибки();
		
		РегистрыСведений.НеЗагруженныеОбъекты.ДобавитьЗаписьОНезагруженномОбъекте(ТекСтрока, ИмяТаблицы, Сч, ТекстОшибки);
		
		Стек = "ИМЯТАБЛИЦЫ: " + ИмяТаблицы + " ПОЛЕ: " + ТекСтрока.F_NREC + " Н: " +Строка(Сч) + " Е: " + Строка(РазмерПроции);
		
		СинхронизацияГалактикаОбщегоНазначения.ОповеститьОбОшибке(ТекстОшибки, Стек, ОбъектДляЗаписи);
		
	КонецПопытки;
	
КонецПроцедуры
