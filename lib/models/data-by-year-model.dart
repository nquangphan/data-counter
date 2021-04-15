import 'package:data_counter/models/data-counter-model.dart';

class DataByYear {
  final String year;
  final double totalData;
  final bool isDecrement;
  final List<Record> quarterData;

  DataByYear(this.year, this.totalData, this.isDecrement, this.quarterData);
}
