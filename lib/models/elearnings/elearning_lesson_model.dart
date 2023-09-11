// To parse this JSON data, do
//
//     final elearningLesson = elearningLessonFromJson(jsonString);

import 'dart:convert';

ElearningLesson elearningLessonFromJson(String str) => ElearningLesson.fromJson(json.decode(str));

String elearningLessonToJson(ElearningLesson data) => json.encode(data.toJson());

class ElearningLesson {
    String? message;
    List<Datum>? data;

    ElearningLesson({
        this.message,
        this.data,
    });

    factory ElearningLesson.fromJson(Map<String, dynamic> json) => ElearningLesson(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? elearningLessonId;
    String? judul;
    String? konten;

    Datum({
        this.elearningLessonId,
        this.judul,
        this.konten,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        elearningLessonId: json["elearningLessonId"],
        judul: json["judul"],
        konten: json["konten"],
    );

    Map<String, dynamic> toJson() => {
        "elearningLessonId": elearningLessonId,
        "judul": judul,
        "konten": konten,
    };
}
