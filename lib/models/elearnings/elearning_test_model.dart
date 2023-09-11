// To parse this JSON data, do
//
//     final elearningTest = elearningTestFromJson(jsonString);

import 'dart:convert';

ElearningTest elearningTestFromJson(String str) => ElearningTest.fromJson(json.decode(str));

String elearningTestToJson(ElearningTest data) => json.encode(data.toJson());

class ElearningTest {
    String? message;
    List<Datum>? data;

    ElearningTest({
        this.message,
        this.data,
    });

    factory ElearningTest.fromJson(Map<String, dynamic> json) => ElearningTest(
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
    int? timeLimit;
    int? questionNumber;
    int? questionId;
    String? question;
    String? choices;
    String? answer;

    Datum({
        this.judul,
        this.timeLimit,
        this.questionNumber,
        this.questionId,
        this.question,
        this.choices,
        this.answer,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        judul: json["judul"],
        timeLimit: json["timeLimit"],
        questionNumber: json["questionNumber"],
        questionId: json["questionId"],
        question: json["question"],
        choices: json["choices"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "judul": judul,
        "timeLimit": timeLimit,
        "questionNumber": questionNumber,
        "questionId": questionId,
        "question": question,
        "choices": choices,
        "answer": answer,
    };
}
