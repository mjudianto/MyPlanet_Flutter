// To parse this JSON data, do
//
//     final elearningCourseDetail = elearningCourseDetailFromJson(jsonString);

import 'dart:convert';

ElearningCourseDetail elearningCourseDetailFromJson(String str) => ElearningCourseDetail.fromJson(json.decode(str));

String elearningCourseDetailToJson(ElearningCourseDetail data) => json.encode(data.toJson());

class ElearningCourseDetail {
    String? message;
    List<Datum>? data;

    ElearningCourseDetail({
        this.message,
        this.data,
    });

    factory ElearningCourseDetail.fromJson(Map<String, dynamic> json) => ElearningCourseDetail(
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
    String? createdBy;
    int? responseCount;
    int? totalLessonsAndTests;
    double? averageRating;

    Datum({
        this.judul,
        this.createdBy,
        this.responseCount,
        this.totalLessonsAndTests,
        this.averageRating,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        judul: json["judul"],
        createdBy: json["createdBy"],
        responseCount: json["response_count"],
        totalLessonsAndTests: json["total_lessons_and_tests"],
        averageRating: json["average_rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "judul": judul,
        "createdBy": createdBy,
        "response_count": responseCount,
        "total_lessons_and_tests": totalLessonsAndTests,
        "average_rating": averageRating,
    };
}
