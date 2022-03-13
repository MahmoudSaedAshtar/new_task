import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/common/constants/storage_keys.dart';
import 'package:task/common/storage/hive_storage.dart';

class LocalChanger with ChangeNotifier, DiagnosticableTreeMixin{
  Locale _appLanguage = Locale(HiveStorage().getFromBox(key: StorageKeys.APPLANGUAGE)??Platform.localeName.substring(0, 2));

  get getAppLanguage => _appLanguage;

  get getAppLanguageId{
    if(_appLanguage.toString() == "en"){
      return 1;
    }else if(_appLanguage.toString() == "ar"){
      return 2;
    }else if(_appLanguage.toString() == "fr"){
      return 3;
    }
  }

  setLanguage(String appLanguage){
    HiveStorage().putInBox(key: StorageKeys.APPLANGUAGE, value: appLanguage);
    _appLanguage = Locale(appLanguage);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('appLanguage :', getAppLanguage));
  }
}