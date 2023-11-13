// To parse this JSON data, do
//
//     final elearningCourseDetail = elearningCourseDetailFromJson(jsonString);

import 'dart:convert';

ElearningCourseDetail elearningCourseDetailFromJson(String str) => ElearningCourseDetail.fromJson(json.decode(str));

String elearningCourseDetailToJson(ElearningCourseDetail data) => json.encode(data.toJson());

class ElearningCourseDetail {
  String? message;
  Data? data;

  ElearningCourseDetail({
    this.message,
    this.data,
  });

  factory ElearningCourseDetail.fromJson(Map<String, dynamic> json) => ElearningCourseDetail(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? elearningCourseId;
  String? judul;
  String? createdBy;
  int? totalLessonsAndTests;
  List<Module>? modules;

  Data({
    this.elearningCourseId,
    this.judul,
    this.createdBy,
    this.totalLessonsAndTests,
    this.modules,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        elearningCourseId: json["elearningCourseId"],
        judul: json["judul"],
        createdBy: json["createdBy"],
        totalLessonsAndTests: json["total_lessons_and_tests"],
        modules: json["modules"] == null ? [] : List<Module>.from(json["modules"]!.map((x) => Module.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "elearningCourseId": elearningCourseId,
        "judul": judul,
        "createdBy": createdBy,
        "total_lessons_and_tests": totalLessonsAndTests,
        "modules": modules == null ? [] : List<dynamic>.from(modules!.map((x) => x.toJson())),
      };
}

class Module {
  int? elearningModuleId;
  String? judul;
  List<Lesson>? lessons;
  List<Test>? tests;

  Module({
    this.elearningModuleId,
    this.judul,
    this.lessons,
    this.tests,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        elearningModuleId: json["elearningModuleId"],
        judul: json["judul"],
        lessons: json["lessons"] == null ? [] : List<Lesson>.from(json["lessons"]!.map((x) => Lesson.fromJson(x))),
        tests: json["tests"] == null ? [] : List<Test>.from(json["tests"]!.map((x) => Test.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "elearningModuleId": elearningModuleId,
        "judul": judul,
        "lessons": lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x.toJson())),
        "tests": tests == null ? [] : List<dynamic>.from(tests!.map((x) => x.toJson())),
      };
}

class Lesson {
  int? elearningLessonId;
  String? judul;
  String? konten;

  Lesson({
    this.judul,
    this.elearningLessonId,
    this.konten,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
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

class Test {
  int? elearningtestid;
  String? judul;
  int? passingScore;
  int? timeLimit;
  int? attempt;
  int? maxAttempt;
  int? score;
  String? status;
  int? adminReply;
  dynamic punishment;
  dynamic adminReplyMessage;

  Test({
    this.elearningtestid,
    this.judul,
    this.passingScore,
    this.timeLimit,
    this.attempt,
    this.maxAttempt,
    this.score,
    this.status,
    this.adminReply,
    this.punishment,
    this.adminReplyMessage,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        elearningtestid: json["elearningtestid"],
        judul: json["judul"],
        passingScore: json["passingScore"],
        timeLimit: json["timeLimit"],
        attempt: json["attempt"],
        maxAttempt: json["maxAttempt"],
        score: json["score"],
        status: json["status"],
        adminReply: json["adminReply"],
        punishment: json["punishment"],
        adminReplyMessage: json["adminReplyMessage"],
      );

  Map<String, dynamic> toJson() => {
        "elearningtestid": elearningtestid,
        "judul": judul,
        "passingScore": passingScore,
        "timeLimit": timeLimit,
        "attempt": attempt,
        "maxAttempt": maxAttempt,
        "score": score,
        "status": status,
        "adminReply": adminReply,
        "punishment": punishment,
        "adminReplyMessage": adminReplyMessage,
      };
}
