import 'package:data_counter/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dimension {
  static double height = 0.0;
  static double width = 0.0;

  static double getWidth(double size) {
    return width * size;
  }

  static double getHeight(double size) {
    return height * size;
  }
}

String getEnvBuild() {
  return bool.fromEnvironment("dart.vm.product") == true
      ? "R"
      : "D" + buildFlavor.toString().split('.').last;
}

appSetup() async {
  sharedPreferences = await SharedPreferences.getInstance();
  appVersion =
      "${packageInfo.version}+${packageInfo.buildNumber} ${getEnvBuild()}";
}
