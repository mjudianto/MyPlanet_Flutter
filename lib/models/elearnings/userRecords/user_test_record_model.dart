// To parse this JSON data, do
//
//     final userTestRecord = userTestRecordFromJson(jsonString);

import 'dart:convert';

UserTestRecord userTestRecordFromJson(String str) => UserTestRecord.fromJson(json.decode(str));

String userTestRecordToJson(UserTestRecord data) => json.encode(data.toJson());

class UserTestRecord {
    String? message;
    List<Datum>? data;

    UserTestRecord({
        this.message,
        this.data,
    });

    factory UserTestRecord.fromJson(Map<String, dynamic> json) => UserTestRecord(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? judul;
    int? elearningTestId;
    dynamic attempt;
    dynamic maxAttempt;
    dynamic score;
    int? passingScore;
    int? timeLimit;

    Datum({
        this.judul,
        this.elearningTestId,
        this.attempt,
        this.maxAttempt,
        this.score,
        this.passingScore,
        this.timeLimit,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        judul: json["judul"],
        elearningTestId: json["elearningTestId"],
        attempt: json["attempt"],
        maxAttempt: json["maxAttempt"],
        score: json["score"],
        passingScore: json["passingScore"],
        timeLimit: json["timeLimit"],
    );

    Map<String, dynamic> toJson() => {
        "judul": judul,
        "elearningTestId": elearningTestId,
        "attempt": attempt,
        "maxAttempt": maxAttempt,
        "score": score,
        "passingScore": passingScore,
        "timeLimit": timeLimit,
    };
}
