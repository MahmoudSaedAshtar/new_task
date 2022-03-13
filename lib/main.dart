import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task/common/constants/provider_list.dart';
import 'package:task/common/localization/app_localization.dart';
import 'package:task/common/providers/local_changer.dart';
import 'package:task/common/storage/hive_storage.dart';
import 'package:task/screens/main_screen.dart';
import 'common/navigation/router.dart' as router;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([HiveStorage().createHive()]);
  runApp(
      MultiProvider(
          providers: ProviderList.providerList,
          child:
      MyApp()));
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      Consumer<LocalChanger>(
          builder: (context, value, child) => MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Task',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en'),
        Locale('ar')
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: value.getAppLanguage,
      onGenerateRoute: router.generateRoute,
      builder: EasyLoading.init(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ), //set desired text scale factor here
            child: child!,
          );
        },
      ),
      home: MainScreen(),
    ));
  }
}
