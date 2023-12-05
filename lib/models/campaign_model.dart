// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  String? message;
  List<Datum>? data;

  Campaign({
    this.message,
    this.data,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? kontenPodtrait;

  Datum({
    this.kontenPodtrait,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kontenPodtrait: json["kontenPodtrait"],
      );

  Map<String, dynamic> toJson() => {
        "kontenPodtrait": kontenPodtrait,
      };
}
