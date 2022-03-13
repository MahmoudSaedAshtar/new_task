import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/common/constants/storage_keys.dart';
import 'package:task/common/storage/hive_storage.dart';

/****
 * author araafat
 */

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of({required BuildContext context}) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    var hiveLangTimeStamp = HiveStorage().getFromBox(key: StorageKeys.APPLANGUAGE_TIMESTAMP);

    String jsonString;

    bool isJsonDownloadFileExist = await File('${HiveStorage().securePath?.path}/lang/${locale.languageCode}.json').exists();

    if(hiveLangTimeStamp != null && isJsonDownloadFileExist) {
      jsonString = await File('${HiveStorage().securePath?.path}/lang/${locale.languageCode}.json').readAsString();
    }else{
      jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    }

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate({required String key}) {
    return _localizedStrings![key] == null ? key : _localizedStrings![key];
  }

  String translateWithArrayInput({required String key, required List trans}) {
    if (_localizedStrings![key] != null) {
      String local = _localizedStrings![key]!;
      for (int i = 0; i < trans.length; i++) {
        local = local.replaceAll('\$\$var' + (i + 1).toString(), trans[i].toString());
      }
      return local;
    } else {
      return key;
    }
  }
}


class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  static const List<String> appLanguages = ['en', 'ar'];
  @override
  bool isSupported(Locale locale) {
    return appLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}