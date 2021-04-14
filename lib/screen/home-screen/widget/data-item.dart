import 'package:data_counter/models/data-counter-model.dart';
import 'package:flutter/material.dart';

class DataItem extends StatelessWidget {
  const DataItem({Key? key, this.record, this.prevRecord}) : super(key: key);
  final Record? record;
  final Record? prevRecord;
  @override
  Widget build(BuildContext context) {
    if (record == null) {
      return SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(record!.quarter ?? 'unknow quarter'),
          Expanded(child: Container()),
          prevRecord != null &&
                  prevRecord!.volumeOfMobileData > record!.volumeOfMobileData
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.trending_down,
                    color: Colors.red,
                    size: 18,
                  ),
                )
              : SizedBox.shrink(),
          Text(record!.volumeOfMobileData.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
