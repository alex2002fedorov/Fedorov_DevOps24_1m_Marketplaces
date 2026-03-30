
//https://api.partner.market.yandex.ru/campaigns
Функция Метод_СписокМагазиновПользователя(Аккаунт) Экспорт 
	
	Метод = "/campaigns";
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьGETЗапрос(Метод, Аккаунт);
	
КонецФункции

//https://api.partner.market.yandex.ru/businesses/{businessId}/offer-mappings
Функция Метод_ИнформацияОТоварахВКаталогах(Аккаунт, СледующаяСтраница, Архив) Экспорт 
	
	businessId = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "BusinessId"); 
	
	Метод = СтрШаблон("/businesses/%1/offer-mappings?page_token=%2&limit=%3", businessId, СледующаяСтраница, 100);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ИнформацияОТоварах(Архив), Метод, Аккаунт);
	
КонецФункции

//https://yandex.ru/dev/market/partner-api/doc/ru/reference/orders/getOrders
Функция Метод_ИнформацияОНесколькихЗаказах(Аккаунт, campaignId, СледующаяСтраница) Экспорт
	
	Если СледующаяСтраница <> "" Тогда
	
		Метод = СтрШаблон("/campaigns/%1/orders?page_token=%2&limit=%3&fake=%4", campaignId, СледующаяСтраница, 800, "false");
		
	Иначе
		
		Метод = СтрШаблон("/campaigns/%1/orders?&limit=%2&fake=%3", campaignId, 800, "false");
	
	КонецЕсли;
	
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьGETЗапрос(Метод, Аккаунт);

КонецФункции

//https://api.partner.market.yandex.ru/businesses/{businessId}/warehouses
Функция Метод_СписокСкладов(Аккаунт) Экспорт
	
	businessId = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "BusinessId");	
	
	Метод = СтрШаблон("/businesses/%1/warehouses", businessId);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьGETЗапрос(Метод, Аккаунт);		

КонецФункции

//https://api.partner.market.yandex.ru/campaigns/{campaignId}/offers/stocks
Функция Метод_ПередачаИнформацииОбОстатках(Аккаунт, campaignId, МассивСтрокНоменклатуры) Экспорт
	
  Метод = СтрШаблон("/campaigns/%1/offers/stocks", campaignId);	  
	
  Возврат рар_мп_HTTP_запросы.ВыполнитьPUTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_СформироватьСписокНоменклатуры(МассивСтрокНоменклатуры), Метод, Аккаунт);
	
КонецФункции

//https://api.partner.market.yandex.ru/campaigns/{campaignId}/orders/{orderId}/boxes
Функция Метод_ПодготовкаЗаказов(Аккаунт, campaignId, НомерЗаказ, РаспределенныеТовары, МаркируемыеТовары, Коробки) Экспорт

	Метод = СтрШаблон("/campaigns/%1/orders/%2/boxes", campaignId, НомерЗаказ);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPUTЗапрос( рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ПодготовкаЗаказа(РаспределенныеТовары,
													МаркируемыеТовары, Коробки),Метод, Аккаунт);		

КонецФункции

//https://api.partner.market.yandex.ru/campaigns/{campaignId}/orders/{orderId}/status
Функция Метод_ИзменениеСтатуса(Аккаунт, campaignId, Заказ, Статус, Подстатус) Экспорт

	Метод = СтрШаблон("/campaigns/%1/orders/%2/status", campaignId, Заказ);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPUTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ИзменениеСтатуса(Статус, Подстатус), Метод, Аккаунт);		

КонецФункции

//https://api.partner.market.yandex.ru/campaigns/{campaignId}/shipments/reception-transfer-act
Функция Метод_ПодтверждениеОгрузки(Аккаунт, campaignId) Экспорт

	Метод = СтрШаблон("/campaigns/%1/shipments/reception-transfer-act", campaignId);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьGETЗапрос(Метод, Аккаунт);
	
		

КонецФункции

//https://api.partner.market.yandex.ru/reports/documents/labels/generate
Функция Метод_ПолучитьЭтикетки(Аккаунт, Заказы) Экспорт

	businessId = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "BusinessId");
	
	СинонимФормат = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "РазмерЭтикетокДляЗаказов");
	
	ИмяПеречисления = СинонимФормат.Метаданные().Имя;
	Индекс = Перечисления[ИмяПеречисления].Индекс(СинонимФормат);
	Формат =СинонимФормат.Метаданные().ЗначенияПеречисления[Индекс].Имя;
	
	Метод = СтрШаблон("/reports/documents/labels/generate?format=%1",Формат);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ПолучениеЭтикетки(businessId, Заказы), Метод, Аккаунт);		

КонецФункции

//https://api.partner.market.yandex.ru/reports/info/{reportId}
Функция Метод_ПолучитьГотовыйОтчет(Аккаунт, НомерОтчета) Экспорт
	
	Метод = СтрШаблон("/reports/info/%1",НомерОтчета);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьGETЗапрос(Метод, Аккаунт);	

КонецФункции

//https://api.partner.market.yandex.ru/reports/goods-realization/generate
Функция Метод_ПолучитьОтчетПоРеализации(Аккаунт, campaignId, Год, Месяц) Экспорт
	
	Метод = "reports/goods-realization/generate?format=";
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ПолучениеОтчетаПоРеализации(campaignId, Год, Месяц), Метод, Аккаунт);
	
КонецФункции

//https://api.partner.market.yandex.ru/reports/united-marketplace-services/generate
Функция Метод_ПолучитьОтчетПоСтоимостиУслуг(Аккаунт, campaignId, НачалоПериода, КонецПериода) Экспорт
	
	businessId = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "BusinessId");
	СхемаРаботы = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Аккаунт, "СхемаРаботы");
	
	Если СхемаРаботы = Перечисления.рар_мп_СхемыРаботы.FBO Тогда
		СхемаРаботы = "FBY";
	ИначеЕсли СхемаРаботы = Перечисления.рар_мп_СхемыРаботы.FBS Тогда
		СхемаРаботы = "FBS";
	КонецЕсли;
	
	Метод = "/reports/united-marketplace-services/generate?format=&language=";
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(
		рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ПолучениеОтчетаПоСтоимостиУслуг(
		Число(businessId), Число(campaignId), Формат(НачалоПериода, "ДФ=yyyy-MM-dd"), Формат(КонецПериода, "ДФ=yyyy-MM-dd"), СхемаРаботы), Метод, Аккаунт
	);
	
КонецФункции

//https://api.partner.market.yandex.ru/campaigns/{campaignId}/offer-prices/updates
Функция Метод_УстановкаЦенНаТоварыВКонкретномМагазине(Данные, Аккаунт, campaignId) Экспорт
	
	Метод = СтрШаблон("campaigns/%1/offer-prices/updates", campaignId);
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ЦеныНоменклатуры(Данные), Метод, Аккаунт);		

КонецФункции

//https://api.partner.market.yandex.ru/reports/stocks-on-warehouses/generate
Функция Метод_ПолучитьОтчетПоОстаткамНаСкладах(Аккаунт, campaignId) Экспорт
	
	Метод = "reports/stocks-on-warehouses/generate?format=";
	
	Возврат рар_мп_HTTP_запросы.ВыполнитьPOSTЗапрос(рар_мп_ЯндексМаркет_JSONЗапросы.СформироватьJSON_ОтчетПоОстаткамНаСкладах(campaignId), Метод, Аккаунт);
	
КонецФункции





