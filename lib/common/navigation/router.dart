import 'dart:developer';

import 'package:task/common/constants/routes.dart';
import 'package:task/common/constants/storage_keys.dart';
import 'package:task/common/storage/hive_storage.dart';
import 'package:task/screens/main_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  log("Route Name:" + settings.name.toString());
  log("Route arg:" + settings.arguments.toString());

  switch (settings.name) {
    case RoutesNames.MainRoute:
      return MaterialPageRoute(
        builder: (context) => MainScreen(),
      );
    default:
      if(HiveStorage().getFromBox(key: StorageKeys.PROFILE_ID) !=null && HiveStorage().getFromBox(key: StorageKeys.PROFILE_ID) !=""){
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
      } else{
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
      }
  }
}
