// To parse this JSON data, do
//
//     final dataCounterResponse = dataCounterResponseFromJson(jsonString);

import 'dart:convert';

DataCounterResponse dataCounterResponseFromJson(String str) =>
    DataCounterResponse.fromJson(json.decode(str));
String dataCounterResponseToJson(DataCounterResponse data) =>
    json.encode(data.toJson());

class DataCounterResponse {
  DataCounterResponse({
    this.help,
    this.success,
    this.result,
  });

  String? help;
  bool? success;
  Result? result;

  DataCounterResponse copyWith({
    String? help,
    bool? success,
    Result? result,
  }) =>
      DataCounterResponse(
        help: help ?? this.help,
        success: success ?? this.success,
        result: result ?? this.result,
      );

  factory DataCounterResponse.fromJson(Map<String, dynamic> json) =>
      DataCounterResponse(
        help: json["help"] == null ? null : json["help"],
        success: json["success"] == null ? null : json["success"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "help": help == null ? null : help,
        "success": success == null ? null : success,
        "result": result == null ? null : result!.toJson(),
      };
}

class Result {
  Result({
    this.resourceId,
    this.fields,
    this.records,
    this.links,
    this.limit,
    this.total,
  });

  String? resourceId;
  List<Field>? fields;
  List<Record>? records;
  Links? links;
  int? limit;
  int? total;

  Result copyWith({
    String? resourceId,
    List<Field>? fields,
    List<Record>? records,
    Links? links,
    int? limit,
    int? total,
  }) =>
      Result(
        resourceId: resourceId ?? this.resourceId,
        fields: fields ?? this.fields,
        records: records ?? this.records,
        links: links ?? this.links,
        limit: limit ?? this.limit,
        total: total ?? this.total,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        resourceId: json["resource_id"] == null ? null : json["resource_id"],
        fields: json["fields"] == null
            ? null
            : List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        records: json["records"] == null
            ? null
            : List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        limit: json["limit"] == null ? null : json["limit"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "resource_id": resourceId == null ? null : resourceId,
        "fields": fields == null
            ? null
            : List<dynamic>.from(fields!.map((x) => x.toJson())),
        "records": records == null
            ? null
            : List<dynamic>.from(records!.map((x) => x.toJson())),
        "_links": links == null ? null : links!.toJson(),
        "limit": limit == null ? null : limit,
        "total": total == null ? null : total,
      };
}

class Field {
  Field({
    this.type,
    this.id,
  });

  String? type;
  String? id;

  Field copyWith({
    String? type,
    String? id,
  }) =>
      Field(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: json["type"] == null ? null : json["type"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "id": id == null ? null : id,
      };
}

class Links {
  Links({
    this.start,
    this.next,
  });

  String? start;
  String? next;

  Links copyWith({
    String? start,
    String? next,
  }) =>
      Links(
        start: start ?? this.start,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        start: json["start"] == null ? null : json["start"],
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "start": start == null ? null : start,
        "next": next == null ? null : next,
      };
}

class Record {
  Record({
    required this.volumeOfMobileData,
    this.quarter,
    this.id,
  });

  double volumeOfMobileData;
  String? quarter;
  int? id;

  Record copyWith({
    double? volumeOfMobileData,
    String? quarter,
    int? id,
  }) =>
      Record(
        volumeOfMobileData: volumeOfMobileData ?? this.volumeOfMobileData,
        quarter: quarter ?? this.quarter,
        id: id ?? this.id,
      );

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        volumeOfMobileData: json["volume_of_mobile_data"] == null
            ? 0
            : double.tryParse(json["volume_of_mobile_data"])??0,
        quarter: json["quarter"] == null ? null : json["quarter"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "volume_of_mobile_data":
            volumeOfMobileData == null ? null : volumeOfMobileData,
        "quarter": quarter == null ? null : quarter,
        "_id": id == null ? null : id,
      };
}
