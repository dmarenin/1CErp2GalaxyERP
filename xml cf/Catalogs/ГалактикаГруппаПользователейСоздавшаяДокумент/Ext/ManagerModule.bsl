﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьДескриптор(Объект) Экспорт
	
	Дескриптор = Неопределено;
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ГалактикаГруппаПользователейСоздавшаяДокумент.Ссылка
	|ИЗ
	|	Справочник.ГалактикаГруппаПользователейСоздавшаяДокумент КАК ГалактикаГруппаПользователейСоздавшаяДокумент
	|ГДЕ
	|	ГалактикаГруппаПользователейСоздавшаяДокумент.Подразделение В ИЕРАРХИИ(&Подразделение)";
	
	Запрос.УстановитьПараметр("Подразделение", Объект.Подразделение);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда 
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		ВыборкаДетальныеЗаписи.Следующий();
		
		Дескриптор = ВыборкаДетальныеЗаписи.Ссылка;
		
	КонецЕсли;
	
	Возврат Дескриптор;
	
КонецФункции

#КонецОбласти

#КонецЕсли