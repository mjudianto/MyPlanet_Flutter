// To parse this JSON data, do
//
//     final elearningCourse = elearningCourseFromJson(jsonString);

import 'dart:convert';

ElearningCourse elearningCourseFromJson(String str) => ElearningCourse.fromJson(json.decode(str));

String elearningCourseToJson(ElearningCourse data) => json.encode(data.toJson());

class ElearningCourse {
    String? message;
    List<Datum>? data;

    ElearningCourse({
        this.message,
        this.data,
    });

    factory ElearningCourse.fromJson(Map<String, dynamic> json) => ElearningCourse(
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
    int? elearningCourseId;
    String? thumbnail;
    String? createdBy;
    String? kategori;
    int? totalLesson;
    int? totalTest;
    int? totalLessonAttempted;
    int? totalTestPassed;
    double? averageRating;
    int? responseCount;
    String? percentage;

    Datum({
        this.judul,
        this.elearningCourseId,
        this.thumbnail,
        this.createdBy,
        this.kategori,
        this.totalLesson,
        this.totalTest,
        this.totalLessonAttempted,
        this.totalTestPassed,
        this.averageRating,
        this.responseCount,
        this.percentage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        judul: json["judul"],
        elearningCourseId: json["elearningCourseId"],
        thumbnail: json["thumbnail"],
        createdBy: json["createdBy"],
        kategori: json["kategori"],
        totalLesson: json["total_lesson"],
        totalTest: json["total_test"],
        totalLessonAttempted: json["total_lesson_attempted"],
        totalTestPassed: json["total_test_passed"],
        averageRating: json["average_rating"]?.toDouble(),
        responseCount: json["response_count"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "judul": judul,
        "elearningCourseId": elearningCourseId,
        "thumbnail": thumbnail,
        "createdBy": createdBy,
        "kategori": kategori,
        "total_lesson": totalLesson,
        "total_test": totalTest,
        "total_lesson_attempted": totalLessonAttempted,
        "total_test_passed": totalTestPassed,
        "average_rating": averageRating,
        "response_count": responseCount,
        "percentage": percentage,
    };
}
