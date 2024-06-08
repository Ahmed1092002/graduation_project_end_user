import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project_end_user/generated/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());
  static LocalizationCubit get(context) => BlocProvider.of(context);

  String? lang;
  String? countryCode;
  var box = Hive.box('localization');
  void changeLang({required String lang}) {
    this.lang = lang;

    emit(LocalizationChangeLang());
  }

  changeLanguage(Locale locale) async {
    await box.put('languageCode', locale.languageCode);

    await box.put('countryCode', locale.countryCode!);
    print(locale);
    S.load(locale);
  }

  bool isArabic() {

    return Intl.getCurrentLocale() == 'ar_EG';
  }
  bool isEnglish() {
    return Intl.getCurrentLocale() == 'en_US';
  }

   ChangeLanguageConndation() async {
    emit(ChangeLanguageLoadingState());
    if (isArabic()) {
   await   changeLanguage(Locale('en', 'US'));
      emit(ChangeLanguageSuccessState());
    } else {
      await changeLanguage(Locale('ar', 'EG'));
      emit(ChangeLanguageSuccessState());
    }
  }
   getCurrentLang() async {
     if (lang == null) {
       lang = 'en';
       countryCode = 'US';
     }
    lang = await box.get('languageCode');
    countryCode = await box.get('countryCode');

    emit(ChangeLanguageSuccessState());
  }

  getLocale() async {
    lang = await box.get('languageCode');
    countryCode = await box.get('countryCode');


return Locale(lang!, countryCode!);
  }

}
