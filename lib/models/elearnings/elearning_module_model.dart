// To parse this JSON data, do
//
//     final elearningModule = elearningModuleFromJson(jsonString);

import 'dart:convert';

ElearningModule elearningModuleFromJson(String str) => ElearningModule.fromJson(json.decode(str));

String elearningModuleToJson(ElearningModule data) => json.encode(data.toJson());

class ElearningModule {
    String? message;
    List<Datum>? data;

    ElearningModule({
        this.message,
        this.data,
    });

    factory ElearningModule.fromJson(Map<String, dynamic> json) => ElearningModule(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? elearningModuleId;
    int? elearningCourseId;
    String? judul;
    int? state;
    int? accessType;
    String? uploadDate;

    Datum({
        this.elearningModuleId,
        this.elearningCourseId,
        this.judul,
        this.state,
        this.accessType,
        this.uploadDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        elearningModuleId: json["elearningModuleId"],
        elearningCourseId: json["elearningCourseId"],
        judul: json["judul"],
        state: json["state"],
        accessType: json["accessType"],
        uploadDate: json["uploadDate"],
    );

    Map<String, dynamic> toJson() => {
        "elearningModuleId": elearningModuleId,
        "elearningCourseId": elearningCourseId,
        "judul": judul,
        "state": state,
        "accessType": accessType,
        "uploadDate": uploadDate,
    };
}
