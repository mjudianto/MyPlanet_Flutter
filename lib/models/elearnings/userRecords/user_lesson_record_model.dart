// To parse this JSON data, do
//
//     final userLessonRecord = userLessonRecordFromJson(jsonString);

import 'dart:convert';

UserLessonRecord userLessonRecordFromJson(String str) => UserLessonRecord.fromJson(json.decode(str));

String userLessonRecordToJson(UserLessonRecord data) => json.encode(data.toJson());

class UserLessonRecord {
  String? message;
  List<Datum>? data;

  UserLessonRecord({
    this.message,
    this.data,
  });

  factory UserLessonRecord.fromJson(Map<String, dynamic> json) => UserLessonRecord(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? lessonName;
  String? attempt;
  String? date;
  String? courseName;

  Datum({
    this.lessonName,
    this.attempt,
    this.date,
    this.courseName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lessonName: json["lessonName"],
        attempt: json["attempt"],
        date: json["date"],
        courseName: json["courseName"],
      );

  Map<String, dynamic> toJson() => {
        "lessonName": lessonName,
        "attempt": attempt,
        "date": date,
        "courseName": courseName,
      };
}
