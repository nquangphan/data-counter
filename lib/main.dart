import 'package:data_counter/screen/home-screen/bloc/home_bloc.dart';
import 'package:data_counter/screen/home-screen/repository/home-repository.dart';
import 'package:data_counter/screen/home-screen/view/home-screen.dart';
import 'package:data_counter/utils/logger.dart';
import 'package:data_counter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';

import 'config.dart';

void main() {
  runApp(MyApp());
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

  printLog("---------> appBaseUrl: $appBaseUrl");
}

runMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupEnv(buildFlavor);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  packageInfo = await PackageInfo.fromPlatform();
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
