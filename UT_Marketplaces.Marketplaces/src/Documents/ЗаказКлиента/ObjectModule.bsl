//@skip-check module-accessibility-at-client
//@skip-check module-structure-method-in-regions
//@skip-check extension-method-prefix
//@skip-check data-exchange-load
&После("ПередЗаписью")
Процедура рар_ТСД_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	//@skip-check undefined-variable
	//@skip-check bsl-legacy-check-dynamic-feature-access
	РаботаСДокументами.ЗарегистрироватьКОбменуПриОчисткеСтатуса(ЭтотОбъект);
КонецПроцедуры