import 'dart:developer';

import 'package:task/common/constants/routes.dart';
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
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );

  }
}
