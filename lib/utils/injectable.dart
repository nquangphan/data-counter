import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => $initGetIt(getIt);

// Future<void> configureDependenciesManual() async {
//   getIt.registerSingletonAsync<SharedPreferences>(
//       () => SharedPreferences.getInstance());

//   getIt.registerSingletonAsync<PackageInfo>(() => PackageInfo.fromPlatform());
// }
