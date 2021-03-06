import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_service.dart';

enum BuildFlavor {
  mockDataOffline,
  mockDataOnline,
  devTeam,
  development,
  staging,
  production
}

BuildFlavor buildFlavor = BuildFlavor.development;

AppApiService appApiService = AppApiService()..init();

String appBaseUrl = "https://data.gov.sg/";

String appVersion = "1.0.0";

SharedPreferences? sharedPreferences;

PackageInfo? packageInfo;
