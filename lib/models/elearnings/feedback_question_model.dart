// To parse this JSON data, do
//
//     final feedbackQuestion = feedbackQuestionFromJson(jsonString);

import 'dart:convert';

FeedbackQuestion feedbackQuestionFromJson(String str) => FeedbackQuestion.fromJson(json.decode(str));

String feedbackQuestionToJson(FeedbackQuestion data) => json.encode(data.toJson());

class FeedbackQuestion {
    String? message;
    List<Datum>? data;

    FeedbackQuestion({
        this.message,
        this.data,
    });

    factory FeedbackQuestion.fromJson(Map<String, dynamic> json) => FeedbackQuestion(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? feedbackQuestionId;
    String? question;
    int? questionType;
    int? type;

    Datum({
        this.feedbackQuestionId,
        this.question,
        this.questionType,
        this.type,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        feedbackQuestionId: json["feedbackQuestionId"],
        question: json["question"],
        questionType: json["questionType"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "feedbackQuestionId": feedbackQuestionId,
        "question": question,
        "questionType": questionType,
        "type": type,
    };
}
