import 'package:data_counter/config.dart';
import 'package:logger/logger.dart';

const FULL_LOG = true;
const String LOG_TAG = "[===DataCounter===]";
final logger = Logger();

void printLog(data) {
  if (buildFlavor != BuildFlavor.production) {
    String text = "$LOG_TAG${data.toString()}";

    if (FULL_LOG == true) {
      final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(text).forEach((match) => print(match.group(0)));
    } else {
      // logger.d(text);
      print(text);
    }
  }
}
