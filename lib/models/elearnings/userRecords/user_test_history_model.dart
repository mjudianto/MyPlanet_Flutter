// To parse this JSON data, do
//
//     final userTestHistory = userTestHistoryFromJson(jsonString);

import 'dart:convert';

UserTestHistory userTestHistoryFromJson(String str) => UserTestHistory.fromJson(json.decode(str));

String userTestHistoryToJson(UserTestHistory data) => json.encode(data.toJson());

class UserTestHistory {
  String? message;
  List<Datum>? data;

  UserTestHistory({
    this.message,
    this.data,
  });

  factory UserTestHistory.fromJson(Map<String, dynamic> json) => UserTestHistory(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? attempt;
  String? judulTest;
  String? judulCourse;
  int? score;
  String? status;
  String? date;

  Datum({
    this.attempt,
    this.judulTest,
    this.judulCourse,
    this.score,
    this.status,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        attempt: json["attempt"],
        judulTest: json["judul_test"],
        judulCourse: json["judul_course"],
        score: json["score"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "attempt": attempt,
        "judul_test": judulTest,
        "judul_course": judulCourse,
        "score": score,
        "status": status,
        "date": date,
      };
}
