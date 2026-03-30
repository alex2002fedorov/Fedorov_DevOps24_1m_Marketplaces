//@skip-check extension-method-prefix
//@skip-check module-structure-method-in-regions
//@skip-check module-accessibility-at-client
//@skip-check doc-comment-parameter-section
Процедура СоздатьШК(Штрихкод, Номенклатура, Характеристика = Неопределено, Упаковка = Неопределено) Экспорт
	//@skip-check manager-module-named-self-reference
	МенеджерЗаписи = РегистрыСведений.ШтрихкодыНоменклатуры.СоздатьМенеджерЗаписи();
	
	МенеджерЗаписи.Штрихкод = Штрихкод;
	МенеджерЗаписи.Номенклатура = Номенклатура;
	МенеджерЗаписи.Характеристика = Характеристика;
	МенеджерЗаписи.Упаковка = Упаковка;
	
	МенеджерЗаписи.Записать();	
КонецПроцедуры