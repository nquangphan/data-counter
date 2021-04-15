import 'package:data_counter/screen/home-screen/view/home-screen.dart';
import 'package:data_counter/utils/injectable.dart';
import 'package:data_counter/utils/logger.dart';
import 'package:data_counter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

void main() {
  runMain();
}

setupEnv(BuildFlavor buildFlavor, [bool runTest = false]) async {
  if (runTest == false) {
    await appSetup();
  }

  switch (buildFlavor) {
    case BuildFlavor.mockDataOffline:
      printLog("===> MOCK data offline <===");
      break;
    case BuildFlavor.staging:
    case BuildFlavor.production:
      appBaseUrl = "https://data.gov.sg/";
      break;
    case BuildFlavor.development:
    case BuildFlavor.devTeam:
      appBaseUrl = "https://data.gov.sg/";
      break;
    default:
      break;
  }
  appApiService.init();
  printLog("---------> appBaseUrl: $appBaseUrl");
}

runMain() async {
  await configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  sharedPreferences = await SharedPreferences.getInstance();
  await setupEnv(buildFlavor);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([]);
  // await DatabaseManager.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen.widget(),
    );
  }
}
